import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Import FirebaseAuth

class SlotSelectionPage extends StatefulWidget {
  @override
  _SlotSelectionPageState createState() => _SlotSelectionPageState();
}

class _SlotSelectionPageState extends State<SlotSelectionPage> {
  String? selectedTiming;
  String? selectedSession;
  String? mobileNumber;  // Variable to store mobile number

  @override
  void initState() {
    super.initState();
    _fetchMobileNumber();  // Fetch mobile number on page load
  }

  Future<void> _fetchMobileNumber() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        mobileNumber = userDoc['mobileNumber'];
      });
    }
  }

  Future<void> saveBookingData(String selectedLocation, String selectedTurf, String userEmail) async {
    // Replace '.' and '@' in email with '_' for Firestore compatibility
    String safeEmail = userEmail.replaceAll('.', '.').replaceAll('@', '@');

    // Check if the slot is already booked
    QuerySnapshot existingBooking = await FirebaseFirestore.instance
        .collection('bookings')
        .where('timing', isEqualTo: selectedTiming)
        .where('session', isEqualTo: selectedSession)
        .where('location', isEqualTo: selectedLocation)
        .where('turf', isEqualTo: selectedTurf)
        .get();

    if (existingBooking.docs.isNotEmpty) {
      // Slot is already booked
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('This slot is already booked. Please choose another one.'),
      ));
    } else {
      // No existing booking, save new booking
      await FirebaseFirestore.instance.collection('bookings').doc(safeEmail).set({
        'timing': selectedTiming,
        'session': selectedSession,
        'location': selectedLocation,  // Save selected location
        'turf': selectedTurf,          // Save selected turf
        'date': DateTime.now(),
        'mobileNumber': mobileNumber,  // Save fetched mobile number
      });
      // Navigate to confirmation page
      Navigator.pushNamed(context, '/confirmation');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Receive both selected location and turf from the previous page
    final Map<String, String> bookingDetails = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String selectedLocation = bookingDetails['selectedLocation']!;
    final String selectedTurf = bookingDetails['selectedTurf']!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            image: AssetImage('assets/image.jpg'), // Background image for Login Page
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            width: 400,
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Select Timing and Session',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Timing:'),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedTiming,
                  items: [
                    '1-2', '2-3', '3-4', '4-5', '5-6', '6-7', '7-8', '8-9', '9-10', '10-11', '11-12'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTiming = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text('Session:'),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedSession,
                  items: ['Morning', 'Evening'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSession = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedTiming != null && selectedSession != null && mobileNumber != null) {
                        User? user = FirebaseAuth.instance.currentUser;
                        String userEmail = user?.email ?? 'No Email';  // Get the user's email
                        saveBookingData(selectedLocation, selectedTurf, userEmail);  // Save booking with email and mobile number
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Loading user details. Please wait.'),
                        ));
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
