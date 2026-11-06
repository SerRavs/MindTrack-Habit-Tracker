import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';

class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: DataStore.habits.length,
        itemBuilder: (context, index) {
          String name = DataStore.habits.keys.elementAt(index);
          int count = DataStore.habits[name]!.completedDates.length;
          return Card(
            color: Colors.teal[50],
            child: ListTile(
              title: Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              trailing: Text("$count Days Completed", style: TextStyle(fontSize: 16, color: Colors.teal)),
            ),
          );
        },
      ),
    );
  }
}