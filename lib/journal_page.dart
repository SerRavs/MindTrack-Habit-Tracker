import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'models.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime _focused = DateTime.now();
  DateTime _selected = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<JournalEntry> entries = DataStore.getJournalForDay(_selected);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text("Journal", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.amber,
        elevation: 0,
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
              calendarStyle: CalendarStyle(selectedDecoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle)),
            ),
          ),
          Expanded(
            child: entries.isEmpty 
             ? Center(child: Text("No entries.", style: GoogleFonts.poppins()))
             : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      title: Text(entries[index].title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      children: [Padding(padding: EdgeInsets.all(16), child: Text(entries[index].body))],
                    ),
                  );
                },
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        backgroundColor: Colors.amber,
        onPressed: _showAddDialog,
      ),
    );
  }

  void _showAddDialog() {
    TextEditingController _title = TextEditingController();
    TextEditingController _body = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("New Entry"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: _title, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: _body, decoration: InputDecoration(labelText: "Content")),
        ]),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (_title.text.isNotEmpty) {
                setState(() => DataStore.addJournalEntry(_selected, _title.text, _body.text));
                Navigator.pop(context);
              }
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }
}