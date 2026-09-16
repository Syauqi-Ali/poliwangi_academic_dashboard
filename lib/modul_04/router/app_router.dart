import 'package:go_router/go_router.dart';

import '../models/announcement.dart';
import '../screens/announcement_list_screen.dart';
import '../screens/announcement_detail_screen.dart';

// Konfigurasi Router Deklaratif GoRouter untuk Modul 04
final modul04Router = GoRouter(
  initialLocation: '/modul-04',
  routes: [
    GoRoute(
      path: '/modul-04',
      builder: (context, state) => const AnnouncementListScreen(),
      routes: [
        GoRoute(
          path: 'detail/:code',
          builder: (context, state) {
            final code = state.pathParameters['code'] ?? '';
            final announcement = state.extra as Announcement;
            return AnnouncementDetailScreen(announcement: announcement);
          },
        ),
      ],
    ),
  ],
);
