// File: lib/screens/siswa/articles.dart

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'article_detail.dart' as detail;
import '../../utils/app_colors.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final List<String> _categories = ['Semua', 'Resep Makanan', 'Gaya Hidup', 'Olahraga'];
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              snap: true,
              expandedHeight: 170,
              backgroundColor: theme.scaffoldBackgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 24.0, bottom: 70.0),
                title: Text(
                  'Artikel',
                  style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onBackground),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari',
                      prefixIcon: Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
                      suffixIcon: Icon(Icons.clear, color: theme.colorScheme.onSurfaceVariant),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: theme.textTheme.bodyMedium,
                    onChanged: (value) {
                      // Tambahkan fitur pencarian nanti jika perlu
                    },
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((category) {
                      final bool isSelected = _selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          selectedColor: theme.colorScheme.primaryContainer,
                          backgroundColor: theme.colorScheme.surfaceVariant,
                          labelStyle: theme.textTheme.labelMedium?.copyWith(
                            color: isSelected ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurfaceVariant,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: isSelected ? BorderSide.none : BorderSide(color: theme.colorScheme.outline),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    'Terbaru',
                    style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onBackground),
                  ),
                  const SizedBox(height: 16),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('artikel').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('Belum ada artikel.');
                      }

                      // Filter berdasarkan kategori jika bukan "Semua"
                      final filteredDocs = _selectedCategory == 'Semua'
                          ? snapshot.data!.docs
                          : snapshot.data!.docs.where((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              final tags = data['tags'] as List<dynamic>? ?? [];
                              return tags.contains(_selectedCategory);
                            }).toList();

                      if (filteredDocs.isEmpty) {
                        return const Text('Artikel tidak ditemukan untuk kategori ini.');
                      }

                      return Column(
                        children: filteredDocs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return _buildArticleCard(
                            theme: theme,
                            title: data['title'] ?? 'Tanpa Judul',
                            content: data['content'] ?? '',
                            tag: data['tags'] != null && (data['tags'] as List).isNotEmpty
                                ? (data['tags'] as List).first
                                : 'Umum',
                            date: data['date'] ?? '',
                            imageUrl: data['imageUrl'] as String?,
                            allTags: List<String>.from(data['tags'] ?? []),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard({
    required ThemeData theme,
    required String title,
    required String content,
    required String tag,
    required String date,
    required String? imageUrl,
    required List<String> allTags,
  }) {
    Widget imageWidget;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('data:image')) {
        try {
          final base64Data = imageUrl.split(',').last;
          final bytes = base64Decode(base64Data);
          imageWidget = Image.memory(
            bytes,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _placeholderImage(theme);
            },
          );
        } catch (e) {
          // Jika decode gagal, tampilkan placeholder
          imageWidget = _placeholderImage(theme);
        }
      } else {
        imageWidget = Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _placeholderImage(theme);
          },
        );
      }
    } else {
      imageWidget = _placeholderImage(theme);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(content, maxLines: 3, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: allTags.map((t) => Chip(label: Text(t))).toList(),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detail.ArticleDetailScreen(
                              title: title,
                              content: content,
                              date: date,
                              tags: allTags,
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: const Text('Baca Selengkapnya'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderImage(ThemeData theme) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.image, size: 40, color: theme.colorScheme.outline),
    );
  }
}
