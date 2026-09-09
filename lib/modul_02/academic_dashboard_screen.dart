import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatelessWidget {
  const AcademicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = Course.getSampleCourses();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Akademik TRPL', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
      ),
      // Versi Smartphone: ListView 1 kolom yang dapat di-scroll vertikal
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const HeaderBanner(), // Banner profil di paling atas
          const SizedBox(height: 16),
          Text(
            'Mata Kuliah Semester 5 (${courses.length} Terdaftar)',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // Render seluruh kartu mata kuliah
          ...courses.map((course) => CourseCard(course: course)),
        ],
      ),
    );
  }
}