
class ShortNameGenerator {

  String createShortName(String fullName) {
    final components = fullName.split(' ');
    final componentsToUse = components.safeSublist(0, 2);
    final firstLetters = componentsToUse.map((e) => e.safeItem(0) ?? '');
    final shortName = firstLetters.join();
    return shortName.toUpperCase();
  }
}

extension ListExtension<T> on List<T> {
  List<T> safeSublist(int start, [int end]) {
    final safeEnd = end > this.length ? this.length : end;
    return this.sublist(start, safeEnd);
  }
}

extension StringExtension on String {

  String safeItem(int index) {
    if (this.isEmpty) { return null; }
    if (index < 0 && index >= this.length) { return null; }
    return this[index];
  }
}