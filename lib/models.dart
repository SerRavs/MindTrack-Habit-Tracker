class JournalEntry {
  final String title;
  final String body;
  final DateTime date;
  JournalEntry({required this.title, required this.body, required this.date});
}

class HabitInfo {
  String reason;
  List<DateTime> completedDates;
  HabitInfo({required this.reason, required this.completedDates});
}