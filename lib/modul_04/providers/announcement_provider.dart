import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/announcement.dart';
import '../repositories/announcement_repository.dart';
import '../repositories/announcement_repository_impl.dart';
import '../repositories/sample_announcement_repository.dart';

const _useSampleData = bool.fromEnvironment('USE_SAMPLE_DATA');

final useSampleDataProvider = Provider<bool>((ref) => _useSampleData);

// Jalankan mode lokal dengan USE_SAMPLE_DATA=true.
final announcementRepositoryProvider = Provider<AnnouncementRepository>((ref) {
  if (ref.watch(useSampleDataProvider)) {
    return SampleAnnouncementRepository();
  }
  return AnnouncementRepositoryImpl();
});

class SelectedCategory extends Notifier<String> {
  @override
  String build() => 'Semua';

  void select(String value) => state = value;
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategory, String>(SelectedCategory.new);

// FutureProvider yang otomatis me-rebuild saat filter kategori berubah
final announcementsProvider = FutureProvider<List<Announcement>>((ref) async {
  final repository = ref.watch(announcementRepositoryProvider);
  final category = ref.watch(selectedCategoryProvider);

  return repository.getAnnouncements(category: category);
});