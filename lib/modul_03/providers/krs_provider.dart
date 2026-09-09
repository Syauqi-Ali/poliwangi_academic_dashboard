import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poliwangi_academic_dashboard/modul_03/models/krs_course.dart';

// Notifier Riverpod 3 untuk mengelola daftar KRS.
class KrsNotifier extends Notifier<List<KrsCourse>> {
  @override
  List<KrsCourse> build() => KrsCourse.getInitialCourses();

  // Menambah mata kuliah ke dalam KRS dengan validasi duplikasi & kuota SKS
  bool tambahMataKuliah(KrsCourse course) {
    // 1. Cek duplikasi kode mata kuliah
    final exists = state.any(
      (c) => c.code.toUpperCase() == course.code.toUpperCase(),
    );
    if (exists) return false;

    // 2. Cek batas maksimal 24 SKS per semester
    if (totalSks + course.sks > 24) return false;

    // 3. Emit state baru secara immutable
    state = [...state, course];
    return true;
  }

  // Menghapus mata kuliah dari KRS
  void hapusMataKuliah(String code) {
    state = state.where((c) => c.code != code).toList();
  }

  // Menghitung total SKS saat ini
  int get totalSks => state.fold(0, (sum, c) => sum + c.sks);
}

// Provider global untuk KRS
final krsProvider = NotifierProvider<KrsNotifier, List<KrsCourse>>(
  KrsNotifier.new,
);

// Provider terkomputasi (computed provider) untuk total SKS
final totalSksProvider = Provider<int>((ref) {
  final courses = ref.watch(krsProvider);
  return courses.fold(0, (sum, c) => sum + c.sks);
});
