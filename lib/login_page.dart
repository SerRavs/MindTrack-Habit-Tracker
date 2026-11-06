import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gratitude_gate.dart';

class LoginPage extends StatelessWidget {
  final _username = TextEditingController();
  final _password = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[700],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.self_improvement, size: 80, color: Colors.white),
              Text("MindTrack", style: GoogleFonts.poppins(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              TextField(
                controller: _username,
                decoration: InputDecoration(filled: true, fillColor: Colors.white, hintText: "Username", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(filled: true, fillColor: Colors.white, hintText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, minimumSize: const Size(double.infinity, 50)),
                onPressed: () {
                  if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GratitudeGateScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                  }
                },
                child: const Text("Login", style: TextStyle(color: Colors.black, fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}