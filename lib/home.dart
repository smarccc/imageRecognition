import 'package:flutter/material.dart';
import 'package:medicinal_plants/contents/containers_buttons_route/plant_info_screen.dart';
import '/contents/medicinal_plants.dart';
import '/contents/image_recognition.dart';
import '/menu_content/about_us.dart'; // Import your About Us page
import '/menu_content/instructions.dart'; // Import your Instructions page
import '/menu_content/qr_code.dart'; // Import your QR Code page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250, // Adjust the height of the header as needed
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 203, 214, 208),
                ),
                child: Image.asset(
                  'assets/images/scslogo.png',
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.get_app_rounded),
              title: Text('Instructions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('QR Code'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodePage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Quit'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add your custom quit functionality if needed
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green,
            height: 80.0, // Height of the top container
            width: double.infinity, // Full width
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0), // Add padding on top and left
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ContainerDemo(),
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (BuildContext context) {
          return FloatingActionButton(
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
            child: Icon(Icons.menu),
            backgroundColor: Colors.green,
          );
        },
      ),
    );
  }
}

class ContainerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // List of names for each box
    final boxNames = ['Lagundi', 'Gumamela', 'Oregano', 'Kalamansi'];

    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                height: screenHeight * 0.30,  // 30% of screen height
                width: screenWidth,           // Full screen width
                child: Column(
                  children: [
                    // Top container with a rectangular image
                    Container(
                      height: screenHeight * 0.15, // 50% of the parent container's height
                      width: screenWidth * 0.8,    // 80% of the screen width
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],  // Background color for image container
                        borderRadius: BorderRadius.circular(10.0), // Optional: rounded corners
                      ),
                      child: Center(
                        child: Image.network(
                          'https://via.placeholder.com/150',  // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Bottom container with a smaller button
                    Container(
                      height: 50.0, // Fixed height for the button container
                      width: screenWidth * 0.5,   // Width for the button container
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageRecognition(),
                            ),
                          );
                        },
                        child: Text(
                          'Image Recognition',
                          style: TextStyle(
                            fontSize: 14,  // Font size
                            color: Colors.white,
                            decoration: TextDecoration.none, // No underline for button text
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,  // Button background color
                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),  // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Rounded corners for the button
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 240, 240, 240),
                height: screenHeight * 0.40,  // 40% of screen height
                width: screenWidth,            // Full screen width
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.40 * 0.10,  // 10% of the height of the main container
                      color: const Color.fromARGB(255, 240, 240, 240),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 20.0), // Add margin to the left
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Medicinal Plants',
                                  style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0), // Space between the text and button
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Medicinal(),
                                ),
                              );
                            },
                            child: Text(
                              'View more',
                              style: TextStyle(
                                fontSize: 14,  // Adjust text size if needed
                                color: const Color.fromARGB(255, 0, 0, 0),
                                decoration: TextDecoration.underline,  // Underline text
                              ),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,  // No background color
                              padding: EdgeInsets.only(right: 20.0),  // Add padding to the right
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.40 * 0.90, // Same height as the parent container
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,  // Enable horizontal scrolling
                            child: Row(
                              children: List.generate(boxNames.length, (index) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),  // Padding: left, top, right, bottom
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate to the route based on container's text
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlantInfoScreen(plantName: boxNames[index]),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: screenWidth * 0.60 - 20.0,  // Adjust width to account for padding
                                      decoration: BoxDecoration(
                                        color: Colors.white,  // Background color of the boxes
                                        borderRadius: BorderRadius.circular(20.0),  // Rounded corners for the boxes
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),  // Shadow color
                                            spreadRadius: 3,  // Spread radius of the shadow
                                            blurRadius: 5,  // Blur radius of the shadow
                                            offset: Offset(0, 3),  // Offset of the shadow
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              boxNames[index],  // Use the corresponding box name
                                              style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
                                            ),
                                            SizedBox(height: 10), // Space between text and image
                                           // Image.asset(
                                             // 'assets/images/sample_image.png',  // Replace with your image asset
                                            //  width: screenWidth * 0.30,  // Width of the image
                                             // height: screenHeight * 0.30 * 0.40,  // Height of the image
                                             // fit: BoxFit.cover,  // Adjust image fit
                                            //),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
