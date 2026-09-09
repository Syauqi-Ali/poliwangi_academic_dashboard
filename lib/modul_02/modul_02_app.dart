import 'package:flutter/material.dart';
import 'package:poliwangi_academic_dashboard/modul_02/academic_dashboard_screen.dart';

class Modul02App extends StatelessWidget {
  const Modul02App({super.key});

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
      home: const AcademicDashboardScreen(),
    );
  }
}
