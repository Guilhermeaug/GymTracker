class TimeUtils {
  static String getCompliment() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Bom dia';
    } else if (hour <= 17) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }
}