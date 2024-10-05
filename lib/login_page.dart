import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              const Text('Login to Turf', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/selectLocation');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
