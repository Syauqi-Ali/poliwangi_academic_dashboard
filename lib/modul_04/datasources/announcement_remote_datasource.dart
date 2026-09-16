import 'package:dio/dio.dart';

import '../models/announcement.dart';

class AnnouncementRemoteDataSource {
  final Dio _dio;

  AnnouncementRemoteDataSource({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: 'https://jsonplaceholder.typicode.com',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 10),
              headers: {'Accept': 'application/json'},
            ),
          ) {
    // Logging interceptor untuk memantau request di terminal
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  // Mengambil daftar pengumuman dari server
  Future<List<Announcement>> fetchAnnouncements() async {
    final response = await _dio.get('/posts');

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data as List<dynamic>;
      final categories = ['Akademik', 'Beasiswa', 'Kegiatan', 'Prestasi'];

      return data.take(10).toList().asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value as Map<String, dynamic>;

        return Announcement(
          id: item['id'] as int? ?? (index + 1),
          title: item['title'] as String? ?? 'Pengumuman Kampus',
          content: item['body'] as String? ?? 'Konten pengumuman akademik.',
          author: 'Bagian Akademik Poliwangi',
          category: categories[index % categories.length],
          date: '2026-09-${(index % 28 + 1).toString().padLeft(2, '0')}',
          readCount: (index + 1) * 37,
        );
      }).toList();
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Gagal mengambil data dari server',
      );
    }
  }

  // Mengirim pengumuman baru (HTTP POST)
  Future<Announcement> createAnnouncement(Announcement announcement) async {
    try {
      final response = await _dio.post('/posts', data: announcement.toJson());
      if (response.statusCode == 201 || response.statusCode == 200) {
        return announcement;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Gagal membuat pengumuman baru',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
