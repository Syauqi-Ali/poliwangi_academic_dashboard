import 'package:go_router/go_router.dart';

import '../models/krs_course.dart';
import '../screens/krs_list_screen.dart';
import '../screens/add_krs_screen.dart';
import '../screens/course_detail_screen.dart';

// Konfigurasi Router Deklaratif GoRouter untuk Modul 03
final modul03Router = GoRouter(
  initialLocation: '/modul-03',
  routes: [
    GoRoute(
      path: '/modul-03',
      builder: (context, state) => const KrsListScreen(),
      routes: [
        GoRoute(path: 'add', builder: (context, state) => const AddKrsScreen()),
        GoRoute(
          path: 'detail/:code',
          builder: (context, state) {
            final code = state.pathParameters['code'] ?? '';
            final course = state.extra as KrsCourse?;
            return CourseDetailScreen(courseCode: code, course: course);
          },
        ),
      ],
    ),
  ],
);
