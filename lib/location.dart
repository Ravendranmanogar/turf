import 'package:flutter/material.dart';

class SelectLocationPage extends StatefulWidget {
  @override
  _SelectLocationPageState createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  String? selectedLocation;

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
    child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select Your Location', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text('Select Location'),
                value: selectedLocation,
                items: ['Villupuram',].map((String location) {//'Pondicherry', 'Villupuram'
                  return DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: selectedLocation != null
                    ? () {
                  // Pass the selected location to the TurfOptionsPage
                  Navigator.pushNamed(
                    context,
                    '/turfOptions',
                    arguments: selectedLocation,
                  );
                }
                    : null,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
