import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'data_store.dart';

class GratitudeJarPage extends StatefulWidget {
  @override
  _GratitudeJarPageState createState() => _GratitudeJarPageState();
}

class _GratitudeJarPageState extends State<GratitudeJarPage> {
  // SPICE 1: A list of quotes to display at the top
  final List<String> _quotes = [
    "Gratitude turns what we have into enough.",
    "Enjoy the little things.",
    "This is a wonderful day.",
    "Happiness blooms from within.",
    "Kindness is free, sprinkle it everywhere.",
    "Start each day with a grateful heart."
  ];

  // SPICE 2: Pastel colors for the cards
  final List<Color> _cardColors = [
    Colors.pink[50]!,
    Colors.purple[50]!,
    Colors.amber[50]!,
    Colors.teal[50]!,
    Colors.blue[50]!,
  ];

  late String _todaysQuote;

  @override
  void initState() {
    super.initState();
    // Pick a random quote when the page loads
    _todaysQuote = _quotes[Random().nextInt(_quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Gratitude Jar 🍯", style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.pink[100],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Column(
        children: [
          // --- SPICE: DAILY QUOTE BANNER ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink[50],
              border: Border(bottom: BorderSide(color: Colors.pink[100]!))
            ),
            child: Column(
              children: [
                Text("Daily Wisdom", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.pink[400])),
                SizedBox(height: 8),
                Text(
                  "\"$_todaysQuote\"",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.grey[800]),
                ),
              ],
            ),
          ),
          
          // --- THE LIST ---
          Expanded(
            child: DataStore.gratitudeJar.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.volunteer_activism, size: 60, color: Colors.pink[200]),
                        SizedBox(height: 10),
                        Text("Jar is empty!", style: GoogleFonts.poppins(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: DataStore.gratitudeJar.length,
                    itemBuilder: (context, index) {
                      // Show newest items first
                      int rIndex = DataStore.gratitudeJar.length - 1 - index;
                      
                      // Cycle through our pastel colors
                      Color cardColor = _cardColors[index % _cardColors.length];

                      return Card(
                        color: cardColor, // Sets the colorful background
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
                            child: Icon(Icons.star, color: Colors.black54, size: 20),
                          ),
                          title: Text(
                            DataStore.gratitudeJar[rIndex], 
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500)
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Shake Jar", style: TextStyle(fontWeight: FontWeight.bold)),
        icon: Icon(Icons.shuffle),
        backgroundColor: Colors.pink[300],
        onPressed: _shakeJar,
      ),
    );
  }

  void _shakeJar() {
    if (DataStore.gratitudeJar.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("The jar is empty! Add some gratitude first."))
        );
        return;
    }
    
    final random = Random();
    var randomItem = DataStore.gratitudeJar[random.nextInt(DataStore.gratitudeJar.length)];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.pink[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.pink),
            SizedBox(width: 10),
            Text("A Happy Memory", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(
          "\"$randomItem\"", 
          style: GoogleFonts.poppins(fontSize: 18, fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("Close", style: TextStyle(color: Colors.pink[800]))
          )
        ],
      ),
    );
  }
}