abstract final class HymnNumber {
  static final RegExp _pattern = RegExp(r'^(\d+)([a-zA-Z]*)$');

  static ({int numeric, String suffix})? tryParse(String raw) {
    final text = raw.trim();
    final match = _pattern.firstMatch(text);
    if (match == null) return null;
    final numeric = int.tryParse(match.group(1)!);
    if (numeric == null) return null;
    return (numeric: numeric, suffix: match.group(2)!.toLowerCase());
  }

  static int numericPart(String raw) => tryParse(raw)?.numeric ?? 0;

  static String fileKey(String raw) {
    final safe = raw.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return safe.isEmpty ? '0' : safe;
  }

  static int compare(String a, String b) {
    final pa = tryParse(a);
    final pb = tryParse(b);
    if (pa == null && pb == null) return a.compareTo(b);
    if (pa == null) return 1;
    if (pb == null) return -1;
    final byNum = pa.numeric.compareTo(pb.numeric);
    if (byNum != 0) return byNum;
    return pa.suffix.compareTo(pb.suffix);
  }
}
