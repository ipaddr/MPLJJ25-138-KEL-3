// File: lib/screens/siswa/article_detail.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final List<String> tags;
  final String? imageUrl;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.tags,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Uint8List? _decodeBase64Image(String? base64Str) {
      if (base64Str == null || base64Str.isEmpty) return null;
      try {
        // Jika ada prefix "data:image/xxx;base64,", ambil bagian setelah koma
        final pureBase64 = base64Str.contains(',') ? base64Str.split(',')[1] : base64Str;
        return base64Decode(pureBase64);
      } catch (e) {
        // Kalau decode gagal, kembalikan null
        return null;
      }
    }

    Widget _buildImage(String? imageUrl) {
      if (imageUrl == null || imageUrl.isEmpty) {
        return _buildPlaceholder(theme);
      }

      if (imageUrl.startsWith('data:image')) {
        final bytes = _decodeBase64Image(imageUrl);
        if (bytes != null) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              bytes,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(theme),
            ),
          );
        } else {
          return _buildPlaceholder(theme);
        }
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildPlaceholder(theme),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Detail Artikel'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dipublikasi: $date',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            _buildImage(imageUrl),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: theme.colorScheme.tertiaryContainer,
                  labelStyle: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              content,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.image,
        size: 60,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
