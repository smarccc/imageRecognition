import 'package:flutter/material.dart';
import 'dart:async';
import './splash_screen.dart'; // Assuming you have a main screen file

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String _currentImage = 'assets/images/cct.png'; // Initial image path
  String _firstText = 'CITY COLLEGE OF'; // Initial first text
  String _secondText = 'TAGAYTAY'; // Initial second text
  double _progress = 0.0; // Initial progress value

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _startProgress();
  }

  Future<void> _initializeApp() async {
    // Change the image and text after 3 seconds
    Timer(Duration(seconds: 3), () {
      setState(() {
        _currentImage = 'assets/images/scslogo.jpg'; // Replace with your second image asset
        _firstText = 'SCHOOL OF COMPUTER'; // Replace with your updated first text
        _secondText = 'STUDIES'; // Replace with your updated second text
      });
    });

    // Wait for 6 seconds before navigating to the next screen
    await Future.delayed(Duration(seconds: 7));

    // Navigate to the main screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  void _startProgress() {
    Timer.periodic(Duration(milliseconds: 60), (Timer timer) {
      setState(() {
        if (_progress < 1) {
          _progress += 1 / 100; // Increment progress
        } else {
          timer.cancel(); // Stop the timer when progress reaches 100%
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate text size based on screen width
    double textSize = screenWidth * 0.05; // 5% of screen width

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Center the column content vertically
              children: <Widget>[
                Image.asset(
                  _currentImage,
                  width: screenWidth * 0.7,  // 70% of screen width
                  height: screenHeight * 0.4,  // 40% of screen height
                  fit: BoxFit.contain, // Adjust this to your preference
                ),
                SizedBox(height: 16.0), // Space between the image and the text
                Text(
                  _firstText, // First text
                  style: TextStyle(
                    color: Colors.green, // Text color green
                    fontSize: textSize, // Set text size based on screen width
                    fontWeight: FontWeight.bold, // Optional: make the text bold
                  ),
                ),
                Text(
                  _secondText, // Second text
                  style: TextStyle(
                    color: Colors.green, // Text color green
                    fontSize: textSize, // Slightly smaller text size for second text
                    fontWeight: FontWeight.bold, // Normal weight for the second text
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0), // Add bottom margin
              child: SizedBox(
                width: screenWidth * 0.8, // 80% of screen width
                child: LinearProgressIndicator(
                  value: _progress, // Set the current progress
                  minHeight: 20, // Set the height of the progress bar
                  color: Colors.green, // Change the progress bar color to green
                  backgroundColor: Colors.grey[300], // Optional: change background color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
