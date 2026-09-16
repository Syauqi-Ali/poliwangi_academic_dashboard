import 'package:dio/dio.dart';
import '../datasources/announcement_remote_datasource.dart';
import '../models/announcement.dart';
import 'announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementRemoteDataSource _remoteDataSource;

  AnnouncementRepositoryImpl({AnnouncementRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? AnnouncementRemoteDataSource();

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    try {
      final list = await _remoteDataSource.fetchAnnouncements();

      if (category == null || category == 'Semua') {
        return list;
      }

      return list.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();
    } on DioException catch (e) {
      // Menerjemahkan DioException ke pesan ramah pengguna
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Koneksi timeout. Periksa internet Anda.');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Tidak dapat terhubung ke server. Periksa jaringan Anda.');
      }
      throw Exception('Terjadi kendala jaringan: ${e.message}');
    } catch (e) {
      throw Exception('Gagal memuat pengumuman: $e');
    }
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    try {
      return await _remoteDataSource.createAnnouncement(announcement);
    } on DioException catch (e) {
      throw Exception('Gagal mengirim pengumuman: ${e.message}');
    }
  }
}