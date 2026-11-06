import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'models.dart';
import 'analytics_page.dart';

class HabitTrackerPage extends StatefulWidget {
  @override
  _HabitTrackerPageState createState() => _HabitTrackerPageState();
}

class _HabitTrackerPageState extends State<HabitTrackerPage> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Habit Tracker", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.bar_chart, color: Colors.teal),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnalyticsPage())),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10),
            child: TableCalendar(
              firstDay: DateTime.utc(2020), lastDay: DateTime.utc(2030),
              focusedDay: _focused,
              selectedDayPredicate: (d) => isSameDay(_selected, d),
              calendarFormat: CalendarFormat.week,
              onDaySelected: (s, f) => setState(() { _selected = s; _focused = f; }),
              calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: DataStore.habits.length,
              itemBuilder: (context, index) {
                String name = DataStore.habits.keys.elementAt(index);
                HabitInfo info = DataStore.habits[name]!;
                bool done = DataStore.isHabitDoneOnDate(name, _selected);
                return Card(
                  child: ListTile(
                    title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                    subtitle: Text(info.reason),
                    trailing: Checkbox(
                      value: done, 
                      activeColor: Colors.teal,
                      onChanged: (v) => setState(() => DataStore.toggleHabitForDate(name, _selected))
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Habit"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: _showAddDialog,
      ),
    );
  }

  void _showAddDialog() {
    TextEditingController _name = TextEditingController();
    TextEditingController _reason = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("New Habit"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _name, decoration: InputDecoration(labelText: "Name")),
          TextField(controller: _reason, decoration: InputDecoration(labelText: "Why?")),
        ]),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_name.text.isNotEmpty) {
                setState(() => DataStore.addNewHabit(_name.text, _reason.text));
                Navigator.pop(context);
              }
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}
