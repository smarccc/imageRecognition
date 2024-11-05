import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Uncommented this line

//import 'contents/image_recognition.dart';
import '../health_condition.dart';
import '../medicinal_plants.dart';
import '../image_recognition.dart';
import '/menu_content/about_us.dart'; // Import your About Us page
import '/menu_content/instructions.dart'; // Import your Instructions page
import '/menu_content/qr_code.dart'; // Import your QR Code page

void main() {
  runApp(const BottomAppBar());
}

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    Navigator.pop(context); // Close the drawer
  }

  void showQuitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure to quit?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                SystemNavigator.pop(); // Quit the app
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250, // Adjust the height of the header as needed
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 255, 123),
                ),
                child: Image.asset(
                  'assets/cct.png',
                  fit: BoxFit.contain, // Adjust the fit as needed
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()), // Navigate to About Us page
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.get_app_rounded),
              title: Text('Instructions'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionsPage()), // Navigate to Instructions page
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('QR Code'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRCodePage()), // Navigate to QR Code page
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Quit'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                showQuitDialog();
              },
            ),
          ],
        ),
      ),
      body: PageView(
        physics: PageScrollPhysics(), // Enable swiping left and right
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const <Widget>[
          ImageRecognition(),
          Medicinal(),
          Therapeutic(),
          // Add more pages as needed
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(225, 62, 167, 1),
          unselectedItemColor: Color.fromARGB(155, 0, 0, 0),
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 2) {
              openDrawer();
            } else {
              setState(() {
                selectedIndex = index;
              });
              pageController.animateToPage(
                selectedIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuad,
              );
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.indeterminate_check_box_sharp),
              label: 'Image Recognition',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_florist_rounded),
              label: 'Medicinal Plants',
            ),
            //BottomNavigationBarItem(
             // icon: Icon(Icons.emoji_food_beverage_rounded),
             // label: 'Health Condition',
           // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu), // Menu icon added here
              label: 'Menu',
            ),
            // Add more items as needed
          ],
        ),
      ),
    );
  }
}
