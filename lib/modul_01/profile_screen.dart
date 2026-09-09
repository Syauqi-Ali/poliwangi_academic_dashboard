import 'package:flutter/material.dart';

class PoliwangiProfileApp extends StatelessWidget {
  const PoliwangiProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa TRPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
        ), // Biru Poliwangi
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Placeholder sementara sebelum diisi konten profil
      // Ganti properti body: const Center(...) dengan kode berikut:
      body: Center(
        // ScrollView dipakai agar UI tetap aman saat orientasi landscape atau layar kecil
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar profil
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF0284C7), width: 3),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 52,
                  color: Color(0xFF0284C7),
                ),
              ),
              const SizedBox(height: 16),

              // Nama mahasiswa
              const Text(
                'Ahmad Syauqi Ali Syahbana', // Ganti dengan nama asli Anda
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 6),

              // Badge NIM
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'NIM: 362558302066', // Ganti dengan NIM asli Anda
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Kartu informasi akademik
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.business_rounded,
                        label: 'Jurusan',
                        value: 'Bisnis dan Informatika',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.code_rounded,
                        label: 'Program Studi',
                        value: 'Sarjana Terapan TRPL',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.location_on_rounded,
                        label: 'Kampus',
                        value: 'Politeknik Negeri Banyuwangi',
                      ),
                      Divider(height: 24, color: Color(0xFFF1F5F9)),
                      _InfoRow(
                        icon: Icons.calendar_today_rounded,
                        label: 'Semester / TA',
                        value: 'Semester 5 (2026/2027)',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Tombol verifikasi dengan feedback SnackBar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Status: Mahasiswa Aktif TRPL — Angkatan 2024',
                        ),
                        backgroundColor: Color(0xFF0284C7),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_user_rounded),
                  label: const Text('Verifikasi Status Mahasiswa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0284C7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget reusable untuk tiap baris informasi profil
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF0284C7)),
        ),
        const SizedBox(width: 14),

        // Expanded agar teks panjang otomatis wrap ke bawah dan tidak overflow
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
