import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({super.key, required this.announcement});

  @override
  State<AnnouncementDetailScreen> createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  bool _isLoading = false;
  bool _hasError = false;

  void _simulasiMuatUlang() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _pemicuError() {
    setState(() {
      _hasError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pengumuman'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Simulasi Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _simulasiMuatUlang,
          ),
          IconButton(
            tooltip: 'Simulasi Error',
            icon: const Icon(Icons.bug_report),
            onPressed: _pemicuError,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // 1. STATE 1: LOADING
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Memuat rincian silabus mata kuliah...',
              style: TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
      );
    }

    // 2. STATE 2: ERROR (dengan Tombol Coba Lagi / Retry)
    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              const Text(
                'Gagal Mengambil Data Silabus',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Terjadi gangguan jaringan saat menghubungi server akademik. Silakan coba kembali.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _simulasiMuatUlang,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF0284C7),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi (Retry)'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. STATE 3: EMPTY (Data tidak ditemukan)
    if (widget.announcement == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off_rounded,
                size: 64,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(height: 16),
              Text(
                'Pengumuman "${widget.announcement.title}" Tidak Ditemukan',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali ke Daftar KRS'),
              ),
            ],
          ),
        ),
      );
    }

    // 4. STATE 4: SUCCESS (Tampilkan Data Lengkap)
    final Announcement = widget.announcement;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge Akademik
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4FE), // Warna biru muda/soft
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  Announcement.category,
                  style: TextStyle(
                    color: Color(0xFF0077D6),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Color(0xFF757575),
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    Announcement.date,
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Judul
          Text(
            Announcement.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),

          // Row Profile Info (Avatar + Nama + Subtitle)
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFDDF2FF),
                child: Icon(Icons.person, color: Color(0xFF0077D6), size: 28),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Announcement.author,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Dibaca ${Announcement.readCount} kali • Terverifikasi',
                    style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Garis Pembatas (Divider)
          const Divider(color: Color(0xFFF1F5F9), thickness: 1.5),
          const SizedBox(height: 16),

          // Deskripsi Paragraf 1
          Text(
            Announcement.content,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF334155),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Deskripsi Paragraf 2
          const Text(
            'Pastikan Anda telah berkonsultasi dengan Dosen Pembimbing Akademik masing-masing sebelum menekan tombol finalisasi kuota.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF334155),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
