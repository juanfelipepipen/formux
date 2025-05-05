class FormuxYearGenerator {
  /// Generate dates from a year to a year
  static List<int> fromTo(int from, int to) {
    List<int> years = [];
    for (int i = from; i < to; i++) {
      years.insert(0, i);
    }
    return years;
  }

  /// Generate dates from a year
  static List<int> from(int from) {
    List<int> years = [];
    int to = DateTime.now().year;
    for (int i = from; i < to; i++) {
      years.insert(0, i);
    }
    return years;
  }
}
