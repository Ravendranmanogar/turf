import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/image.jpg'), // Background image for Login Page
    fit: BoxFit.cover,
    ),
    ),
    child: const Center(
        child: Padding(
          padding: EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Slot is Booked', style: TextStyle(fontSize: 36,color: Colors.white)),
              SizedBox(height: 20),
              Text('Thanks for Booking and Come Again!', style: TextStyle(fontSize: 24,color: Colors.white)),
            ],
          ),
        ),
      ),
    )
    );
  }
}
