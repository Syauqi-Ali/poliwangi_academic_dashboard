import '../models/announcement.dart';
import 'announcement_repository.dart';

class SampleAnnouncementRepository implements AnnouncementRepository {
  final List<Announcement> _items = Announcement.getSampleAnnouncements();

  @override
  Future<List<Announcement>> getAnnouncements({String? category}) async {
    if (category == null || category == 'Semua') {
      return List<Announcement>.unmodifiable(_items);
    }
    return _items.where((item) {
      return item.category.toLowerCase() == category.toLowerCase();
    }).toList(growable: false);
  }

  @override
  Future<Announcement> addAnnouncement(Announcement announcement) async {
    _items.add(announcement);
    return announcement;
  }
}