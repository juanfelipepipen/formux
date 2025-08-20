class FormuxYearGenerator {
  /// Generate dates from a year to a year
  static List<int> fromTo(int from, int to) {
    final years = <int>[];

    for (int i = from; i < to; i++) {
      years.insert(0, i);
    }

    return years;
  }

  /// Generate dates from a year
  static List<int> from(int from) {
    final years = <int>[];
    final to = DateTime.now().year;

    for (int i = from; i < to; i++) {
      years.insert(0, i);
    }

    return years;
  }

  static List<int> fromNowTo({required int maxYears}) {
    final years = <int>[];
    final from = DateTime.now().year;
    final to = from + maxYears;

    for (int i = from; i < to; i++) {
      years.add(i);
    }

    return years;
  }
}
