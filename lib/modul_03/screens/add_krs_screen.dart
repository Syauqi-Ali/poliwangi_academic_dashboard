import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/krs_course.dart';
import '../providers/krs_provider.dart';

class AddKrsScreen extends ConsumerStatefulWidget {
  const AddKrsScreen({super.key});

  @override
  ConsumerState<AddKrsScreen> createState() => _AddKrsScreenState();
}

class _AddKrsScreenState extends ConsumerState<AddKrsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _lecturerController = TextEditingController();
  final _sksController = TextEditingController(text: '3');
  final _descController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _lecturerController.dispose();
    _sksController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _simpanMataKuliah() {
    if (_formKey.currentState?.validate() ?? false) {
      final newCourse = KrsCourse(
        code: _codeController.text.trim().toUpperCase(),
        name: _nameController.text.trim(),
        lecturer: _lecturerController.text.trim(),
        sks: int.tryParse(_sksController.text.trim()) ?? 3,
        description: _descController.text.trim(),
      );

      final success = ref
          .read(krsProvider.notifier)
          .tambahMataKuliah(newCourse);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Mata kuliah "${newCourse.name}" berhasil ditambahkan ke KRS.',
            ),
            backgroundColor: const Color(0xFF059669),
            behavior: SnackBarBehavior.floating,
          ),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Gagal: Kode MK sudah terdaftar atau total SKS melebihi 24!',
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mata Kuliah KRS'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Kode Mata Kuliah
              TextFormField(
                controller: _codeController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  labelText: 'Kode Mata Kuliah *',
                  hintText: 'Contoh: TRPL504',
                  prefixIcon: Icon(Icons.qr_code),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode mata kuliah wajib diisi';
                  }
                  if (value.trim().length < 4) {
                    return 'Kode minimal terdiri dari 4 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 2. Nama Mata Kuliah
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah *',
                  hintText: 'Contoh: Pemrograman Framework Mobile',
                  prefixIcon: Icon(Icons.book_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama mata kuliah wajib diisi';
                  }
                  if (value.trim().length < 5) {
                    return 'Nama minimal terdiri dari 5 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 3. Dosen Pengampu
              TextFormField(
                controller: _lecturerController,
                decoration: const InputDecoration(
                  labelText: 'Dosen Pengampu *',
                  hintText: 'Contoh: Sepyan Purnama Kristanto, M.Kom.',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama dosen wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 4. Bobot SKS
              TextFormField(
                controller: _sksController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Bobot SKS (1–6) *',
                  prefixIcon: Icon(Icons.confirmation_number_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bobot SKS wajib diisi';
                  }
                  final sks = int.tryParse(value.trim());
                  if (sks == null || sks < 1 || sks > 6) {
                    return 'SKS harus berupa angka antara 1 sampai 6';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 5. Deskripsi Ringkas (Opsional)
              TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi / Silabus Ringkas',
                  prefixIcon: Icon(Icons.notes),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              FilledButton.icon(
                onPressed: _simpanMataKuliah,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.save),
                label: const Text(
                  'Simpan ke Rencana Studi',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
