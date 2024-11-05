import 'package:flutter/material.dart';
import '../styles/style.dart';
import 'containers_buttons_route/health_condition_info_screen.dart'; // Import the new Dart file

void main() {
  runApp(const Therapeutic());
}

class Therapeutic extends StatelessWidget {
  const Therapeutic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TherapeuticHomePage(),
    );
  }
}

class TherapeuticHomePage extends StatefulWidget {
  @override
  _MedicinalHomePageState createState() => _MedicinalHomePageState();
}

class _MedicinalHomePageState extends State<TherapeuticHomePage> {
  String _searchQuery = '';
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 0),
            color: colorSmokeWhite,
            width: double.infinity,
            height: 60,
            child: const Text(
              'Health Conditions',
              style: headerStyle
            ),
          ),
          
          Container(
            height: screenHeight * 0.35, // Adjust the height as needed
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      _buildImagePage('assets/images/herbal.png', screenHeight, screenWidth),
                      _buildImagePage('assets/images/herbal.png', screenHeight, screenWidth),
                      _buildImagePage('assets/images/herbal.png', screenHeight, screenWidth),
                    ],
                  ),
                ),
                
                _buildPageIndicator(3), // Number of images
                SearchBar(updateQuery: _updateSearchQuery),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContainerGrid(
                searchQuery: _searchQuery,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePage(String imagePath, double screenHeight, double screenWidth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: screenWidth * 0.9, // 90% of screen width
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: screenHeight * 0.25,
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? colorGreen : Colors.grey, //bullet color
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) updateQuery;

  SearchBar({required this.updateQuery});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FocusNode _focusNode; // Create a FocusNode to manage focus

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialize the FocusNode
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // Container for the search bar
          Expanded(
            flex: 4, // Takes 4 parts of the space
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: TextField(
                focusNode: _focusNode, // Attach the FocusNode to the TextField
                textAlign: TextAlign.left, // Align text to the left
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  hintText: 'Search Medicinal Plants', // Placeholder text
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) {
                  widget.updateQuery(value);
                },
              ),
            ),
          ),
          SizedBox(width: 10), // Space between search bar and icon
          // Container for the search icon
          Expanded(
            flex: 1, // Takes 1 part of the space
            child: Container(
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorGreen, // Change to your desired background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(Icons.search, color: colorSmokeWhite), // Adjust icon color if needed
                onPressed: () {
                  // Request focus on the search bar when the icon is pressed
                  FocusScope.of(context).requestFocus(_focusNode);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final String searchQuery;

  final List<Item> items = [
    Item(imagePath: 'assets/images/herbal.png', text: 'Abdominal pain', filter: 1),
    Item(imagePath: 'assets/images/herbal.png', text: 'Allergy', filter: 1),
    Item(imagePath: 'assets/images/herbal.png', text: 'Anemia', filter: 2),
    Item(imagePath: 'assets/images/herbal.png', text: 'Arthritis', filter: 2),
    Item(imagePath: 'assets/images/herbal.png', text: 'Asthma', filter: 3),
    Item(imagePath: 'assets/images/herbal.png', text: 'Body Pain', filter: 3),
    Item(imagePath: 'assets/images/herbal.png', text: 'Boils', filter: 4),
    Item(imagePath: 'assets/images/herbal.png', text: 'Breast Cancer', filter: 4),
    Item(imagePath: 'assets/images/herbal.png', text: 'Bruises', filter: 0),
  ];

  ContainerGrid({required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    List<Item> filteredItems = items
        .where((item) =>
            item.text.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantInfoScreen(plantName: filteredItems[index].text),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: MyContainer(item: filteredItems[index]),
          ),
        );
      },
    );
  }
}

class MyContainer extends StatelessWidget {
  final Item item;

  MyContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerWidth = screenWidth * 0.80;
    double containerHeight = screenWidth * 0.25;

    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 0),
      decoration: BoxDecoration(
        color: colorSmokeWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: containerWidth,
      height: containerHeight,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: SizedBox(
                width: 24, // Specify the width
                height: 24, // Specify the height
                child: Image.asset('assets/images/icons8-spinach-48.png'), // Replace with your image path
              ),
              onPressed: () {
                // Implement your bookmark button functionality here
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.cover,
                    width: containerWidth * 0.30,
                    height: containerHeight * 0.90,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.text,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 10, 10, 10),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Item {
  final String imagePath;
  final String text;
  final int filter;

  Item({required this.imagePath, required this.text, required this.filter});
}
