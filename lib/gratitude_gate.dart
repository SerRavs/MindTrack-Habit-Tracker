import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_store.dart';
import 'home_layout.dart';

class GratitudeGateScreen extends StatefulWidget {
  @override
  _GratitudeGateScreenState createState() => _GratitudeGateScreenState();
}

class _GratitudeGateScreenState extends State<GratitudeGateScreen> {
  final List<TextEditingController> _inputs = [TextEditingController(), TextEditingController(), TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.lock_open, size: 60, color: Colors.teal),
                SizedBox(height: 20),
                Text("Unlock Your Day", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("List 3 things you are grateful for to proceed.", textAlign: TextAlign.center),
                SizedBox(height: 30),
                ...List.generate(3, (i) => Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _inputs[i],
                    decoration: InputDecoration(hintText: "${i+1}. I am grateful for...", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                )),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
                  onPressed: () {
                    if (_inputs.every((c) => c.text.isNotEmpty)) {
                      DataStore.addToJar(_inputs.map((c) => c.text).toList());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeLayout()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields!")));
                    }
                  },
                  child: Text("Enter MindTrack", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}