class KrsCourse {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final String description;

  const KrsCourse({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    this.description = '',
  });

  static List<KrsCourse> getInitialCourses() {
    return const [
      KrsCourse(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto, M.Kom.',
        sks: 3,
        description: 'Membangun aplikasi mobile cross-platform modern dengan Flutter dan Riverpod.',
      ),
      KrsCourse(
        code: 'TRPL502',
        name: 'Rekayasa Perangkat Lunak Lanjut',
        lecturer: 'Tim Dosen TRPL',
        sks: 3,
        description: 'Penerapan Clean Architecture, Design Patterns, dan CI/CD pipeline.',
      ),
      KrsCourse(
        code: 'TRPL503',
        name: 'Manajemen Basis Data Terdistribusi',
        lecturer: 'Tim Dosen TRPL',
        sks: 3,
        description:
            'Pengelolaan basis data NoSQL dan relasional berskala besar.',
      ),
    ];
  }
}
