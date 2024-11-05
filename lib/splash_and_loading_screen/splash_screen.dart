import 'package:flutter/material.dart';
import '/home.dart'; // Import the new screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'splashScrenn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showLoadingScreen = true;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        final newPage = page.round();
        if (_currentPage != newPage) {
          setState(() {
            _currentPage = newPage;
          });
        }
      }
    });

    // Show the loading screen for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showLoadingScreen = false;
      });
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Navigate to the new screen when on the last slide
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  void _skipToEnd() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedOpacity(
            opacity: _showLoadingScreen ? 0.3 : 1.0, // Change opacity based on loading screen state
            duration: Duration(milliseconds: 300),
            child: IgnorePointer(
              ignoring: _showLoadingScreen, // Disable touch when loading screen is active
              child: PageView(
                controller: _pageController,
                children: [
                  _buildPage('assets/images/title.png', ''),
                  _buildPage('assets/images/herbal.png', 'Slide 2'),
                  _buildPage('assets/images/herbal.png', 'Slide 3'),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton(
              onPressed: _skipToEnd,
              child: Text('Skip'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey, // Button background color
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: _currentPage == index ? 20 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 20,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: _currentPage == 2 ? Text('Start') : Text('Next'),
            ),
          ),
          if (_showLoadingScreen)
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(String imagePath, String text) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;

        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: screenHeight * 0.4, // 40% of the screen height
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20), // Spacing between image and text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                  textAlign: TextAlign.center,
                  maxLines: 3, // Set the maximum number of lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
