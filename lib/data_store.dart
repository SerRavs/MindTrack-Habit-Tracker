import 'models.dart';

class DataStore {
  // --- Gratitude Jar ---
  static List<String> gratitudeJar = ["I woke up today", "The sun is out"];
  static void addToJar(List<String> newItems) => gratitudeJar.addAll(newItems);

  // --- Journal ---
  static Map<String, List<JournalEntry>> journalEntries = {};
  
  static List<JournalEntry> getJournalForDay(DateTime date) {
    return journalEntries[_formatDate(date)] ?? [];
  }

  static void addJournalEntry(DateTime date, String title, String body) {
    String key = _formatDate(date);
    if (!journalEntries.containsKey(key)) journalEntries[key] = [];
    journalEntries[key]!.add(JournalEntry(title: title, body: body, date: DateTime.now()));
  }

  // --- Habits ---
  static Map<String, HabitInfo> habits = {
    "Drink Water": HabitInfo(reason: "Health", completedDates: []),
    "Code 1 Hour": HabitInfo(reason: "School Project", completedDates: []),
  };

  static void addNewHabit(String name, String reason) {
    if (!habits.containsKey(name)) {
      habits[name] = HabitInfo(reason: reason, completedDates: []);
    }
  }

  static void removeHabit(String name) => habits.remove(name);

  static bool isHabitDoneOnDate(String name, DateTime date) {
    final habit = habits[name];
    if (habit == null) return false;
    return habit.completedDates.any((d) => _formatDate(d) == _formatDate(date));
  }

  static void toggleHabitForDate(String name, DateTime date) {
    final habit = habits[name];
    if (habit == null) return;
    if (isHabitDoneOnDate(name, date)) {
      habit.completedDates.removeWhere((d) => _formatDate(d) == _formatDate(date));
    } else {
      habit.completedDates.add(date);
    }
  }

  static String _formatDate(DateTime dt) => "${dt.year}-${dt.month}-${dt.day}";
}