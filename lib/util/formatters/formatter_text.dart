class FormatterText {
  static String formatFileSize(int bytes) {
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return "${size.toStringAsFixed(2)} ${suffixes[i]}";
  }
}