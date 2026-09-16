// Model data untuk pengumuman akademik
class Announcement {
  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    this.readCount = 0,
  });

  // Factory constructor untuk mem-parsing data JSON dari REST API
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Bagian Akademik Poliwangi',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'category': category,
      'date': date,
      'readCount': readCount,
    };
  }

  // Data tiruan untuk fallback offline atau testing
  static List<Announcement> getSampleAnnouncements() {
    return const [
      Announcement(
        id: 1,
        title: 'Jadwal Pengisian KRS Semester Ganjil 2026/2027',
        content: 'Pengisian KRS untuk mahasiswa tingkat 3 Sarjana Terapan TRPL dimulai tanggal 1 hingga 7 September 2026.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 142,
      ),
      Announcement(
        id: 2,
        title: 'Pendaftaran Program Magang Industri Bersertifikat Batch 7',
        content: 'Kesempatan magang 6 bulan di perusahaan teknologi mitra jurusan. Mahasiswa semester 5 dapat mendaftar.',
        author: 'Koordinator Magang TRPL',
        category: 'Kegiatan',
        date: '2026-09-02',
        readCount: 89,
      ),
    ];
  }
}
