import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class InputArtikelScreen extends StatefulWidget {
  const InputArtikelScreen({super.key});

  @override
  State<InputArtikelScreen> createState() => _InputArtikelScreenState();
}

class _InputArtikelScreenState extends State<InputArtikelScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();
  final TextEditingController _penulisController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  Uint8List? _selectedImageBytes;
  String? _base64Image;

  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _selectedImageBytes = result.files.single.bytes;

          
          _base64Image = 'data:image/jpeg;base64,${base64Encode(_selectedImageBytes!)}';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memilih gambar: $e")),
      );
    }
  }

  Future<void> _submitArtikel() async {
    if (_judulController.text.isEmpty ||
        _isiController.text.isEmpty ||
        _penulisController.text.isEmpty ||
        _tagController.text.isEmpty ||
        _base64Image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap lengkapi semua data.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('artikel').add({
        'title': _judulController.text.trim(),
        'content': _isiController.text.trim(),
        'author': _penulisController.text.trim(),
        'date': DateTime.now().toIso8601String().split('T').first,
        'tags': [_tagController.text.trim()],
        'imageUrl': _base64Image, // ✅ Disimpan di field yang benar
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Artikel berhasil disimpan.")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan: $e")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    _penulisController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  bool get _isInputValid {
    return _judulController.text.isNotEmpty &&
        _isiController.text.isNotEmpty &&
        _penulisController.text.isNotEmpty &&
        _tagController.text.isNotEmpty &&
        _base64Image != null &&
        !_isLoading;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Artikel"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(labelText: "Judul Artikel"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Isi Artikel"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _penulisController,
              decoration: const InputDecoration(labelText: "Nama Penulis"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tagController,
              decoration: const InputDecoration(labelText: "Tag (misal: Sarapan)"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pilih Gambar"),
            ),
            const SizedBox(height: 16),
            if (_selectedImageBytes != null)
              Image.memory(
                _selectedImageBytes!,
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isInputValid ? _submitArtikel : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Simpan Artikel"),
            ),
          ],
        ),
      ),
    );
  }
}
