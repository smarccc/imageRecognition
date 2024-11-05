import 'package:flutter/material.dart';
import 'package:medicinal_plants/contents/containers_buttons_route/plant_info_screen.dart';
import '../styles/style.dart';
import '/home.dart';
void main() {
  runApp(const Medicinal());
}

class Medicinal extends StatelessWidget {
  const Medicinal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicinalHomePage(),
    );
  }
}

class MedicinalHomePage extends StatefulWidget {
  @override
  _MedicinalHomePageState createState() => _MedicinalHomePageState();
}

class _MedicinalHomePageState extends State<MedicinalHomePage> {
  String _searchQuery = '';
  int _selectedFilterIndex = 0;

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _updateFilterIndex(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
       // backgroundColor: Color.fromARGB(255, 255, 255, 255), // Background color of the AppBar
       // toolbarHeight: 0, // Adjust the height of the AppBar
       // elevation: 0, // Optional: Remove shadow for a flat look
     // ),
      body: Column(
        children: [
          Container(
  padding: EdgeInsets.only(top: 30, bottom: 0, left: 0, right: 0),
  color: colorSmokeWhite,
  width: double.infinity,
  height: 60, // Adjust the height of the container
  child: Row(
    children: [
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
      const SizedBox(width: 10), // Add spacing between the button and the text
      const Text(
        'Medicinal Plants',
        style: headerStyle,
      ),
    ],
  ),
),

          SearchBar(updateQuery: _updateSearchQuery),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90, // Set width to 90% of screen width
                    child: FilterButtons(
                      updateFilterIndex: _updateFilterIndex,
                      selectedFilterIndex: _selectedFilterIndex,
                    ),
                  ),
                  ContainerGrid(
                    searchQuery: _searchQuery,
                    selectedFilterIndex: _selectedFilterIndex,
                  ),
                ],
              ),
            ),
          ),
        ],
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


class FilterButtons extends StatelessWidget {
  final Function(int) updateFilterIndex;
  final int selectedFilterIndex;

  FilterButtons({required this.updateFilterIndex, required this.selectedFilterIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        children: [
          // Wrap FilterButton with Container to add margin
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Add top and bottom margin
            child: FilterButton(
              index: 0,
              label: 'All',
              updateFilterIndex: updateFilterIndex,
              isActive: selectedFilterIndex == 0, // Check if active
            ),
          ),
          SizedBox(width: 10), // Space between buttons
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Add top and bottom margin
            child: FilterButton(
              index: 1,
              label: 'Herb',
              updateFilterIndex: updateFilterIndex,
              isActive: selectedFilterIndex == 1,
            ),
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Add top and bottom margin
            child: FilterButton(
              index: 2,
              label: 'Shrub',
              updateFilterIndex: updateFilterIndex,
              isActive: selectedFilterIndex == 2,
            ),
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Add top and bottom margin
            child: FilterButton(
              index: 3,
              label: 'Vine',
              updateFilterIndex: updateFilterIndex,
              isActive: selectedFilterIndex == 3,
            ),
          ),
          SizedBox(width: 10),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10), // Add top and bottom margin
            child: FilterButton(
              index: 4,
              label: 'Tree',
              updateFilterIndex: updateFilterIndex,
              isActive: selectedFilterIndex == 4,
            ),
          ),
          // Add more FilterButton widgets with SizedBox and Container if needed
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final int index;
  final String label;
  final Function(int) updateFilterIndex;
  final bool isActive;

  FilterButton({
    required this.index,
    required this.label,
    required this.updateFilterIndex,
    this.isActive = false, // Default to not active
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Border
        Container(
          width: 75, // Adjust border size as needed
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? colorGreen : Colors.grey,
              width: 3, // Adjust border width
            ),
          ),
        ),
        // Button
        ElevatedButton(
          onPressed: () {
            updateFilterIndex(index);
          },
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black, // Active text color
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? colorGreen : Colors.white, // Active background color
            shape: CircleBorder(), // Make the button circular
            padding: EdgeInsets.all(10), // Adjust padding to control button size
            minimumSize: Size(60, 60), // Set minimum size for the circular button
          ),
        ),
      ],
    );
  }
}

class ContainerGrid extends StatelessWidget {
  final String searchQuery;
  final int selectedFilterIndex;

  final List<Item> items = [
   // Item(imagePath: 'assets/images/herbal.png', text: 'Abukado', filter: 1),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Acacia', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Akapulko', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Alagaw', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Altamisa', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Alugbati', filter: 3),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Ampalaya', filter: 4),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Anonang', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Anonas', filter: 0),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Aratiles', filter: 0),

    // Item(imagePath: 'assets/images/herbal.png', text: 'Ashitaba', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Asparagus', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Atis', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Atsuete', filter: 2),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Balbas Pusa/Taheebo', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Banaba', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Bawang', filter: 4),
    Item(imagePath: 'assets/images/leaves/bayabas.png', text: 'Bayabas', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Bignay', filter: 0),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Buko/Niyog', filter: 0),

    //    Item(imagePath: 'assets/images/herbal.png', text: 'Carrot', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Damong Maria', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Dandelion', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Duhat', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Eucalyptus', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Gabi', filter: 3),
    Item(imagePath: 'assets/images/leaves/gumamela.png', text: 'Gumamela', filter: 4),
    Item(imagePath: 'assets/images/leaves/guyabano.png', text: 'Guyabano', filter: 4),
    //Item(imagePath: 'assets/images/herbal.png', text: 'Hinlalayon/Hikaw-hikawan', filter: 0),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Ikmo', filter: 0),

        Item(imagePath: 'assets/images/leaves/ipil-ipil.png', text: 'Ipil-ipil', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kaimito', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kakawate', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kalamansi', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kamias', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kangkong', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kantutay', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kapili', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Kasopangil', filter: 0),
    Item(imagePath: 'assets/images/leaves/katakataka.png', text: 'Katakataka', filter: 0),

  //      Item(imagePath: 'assets/images/herbal.png', text: 'Katanda', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'kintsay', filter: 1),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Kogon', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Kutsay', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Labanos', filter: 3),
    Item(imagePath: 'assets/images/leaves/lagundi.png', text: 'Lagundi', filter: 3),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Langka', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Lanting', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Laurel', filter: 0),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Lemon', filter: 0),

  //      Item(imagePath: 'assets/images/herbal.png', text: 'Lipa', filter: 1),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Litlit', filter: 1),
 //   Item(imagePath: 'assets/images/herbal.png', text: 'Lubigan', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Luya', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Luyang dilaw', filter: 3),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Mabolo', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Mais', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Makabuhay', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Makahiya', filter: 0),
    Item(imagePath: 'assets/images/leaves/malunggay.png', text: 'Malunggay', filter: 0),

   //     Item(imagePath: 'assets/images/herbal.png', text: 'Mangga', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Mangosteen', filter: 1),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Mayana', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Mirasol', filter: 2),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Morado', filter: 3),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Mustasa', filter: 3),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Niog-niogan', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Okra', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Orange', filter: 0),
    Item(imagePath: 'assets/images/leaves/oregano.png', text: 'Oregano/Klabo', filter: 0),

   //     Item(imagePath: 'assets/images/herbal.png', text: 'Pandakaki', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Pandan', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Pansit-pansitan', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Papaya', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Paragis', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Pinya', filter: 3),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Pipino', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Rosas', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Saluyot', filter: 0),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Sambong', filter: 0),

   //     Item(imagePath: 'assets/images/herbal.png', text: 'Sampaguita', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Sampa-sampalukan', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Santol', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Serpentina/Likha', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Sibuyas tagalog', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Sili', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Sulasi', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tagbak', filter: 4),
  //  Item(imagePath: 'assets/images/herbal.png', text: 'Tanglad/Salay', filter: 0),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tawa-tawa', filter: 0),

    //Item(imagePath: 'assets/images/herbal.png', text: 'Tsaang-gubat', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tsiko', filter: 1),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tsitsirika', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tuba', filter: 2),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Tuba-tuba', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Upo', filter: 3),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Yacon', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Yerba buena', filter: 4),
   // Item(imagePath: 'assets/images/herbal.png', text: 'Ylang-ylang', filter: 0),
    
    // Add more items with appropriate filters
  ];

  ContainerGrid({required this.searchQuery, required this.selectedFilterIndex});

  @override
  Widget build(BuildContext context) {
    List<Item> filteredItems = items
        .where((item) =>
            item.text.toLowerCase().contains(searchQuery.toLowerCase()) &&
            (selectedFilterIndex == 0 || item.filter == selectedFilterIndex))
        .toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    // Use Row for single item, Wrap for multiple items
    if (filteredItems.length == 1) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.only(top: 0, left: 30), // Margin to avoid sticking to the edge
          child: MyContainer(item: filteredItems.first),
        ),
      );
    } else {
      return Wrap(
        spacing: 25, // Horizontal space between containers
        children: filteredItems.map((item) => MyContainer(item: item)).toList(),
      );
    }
  }
}

class MyContainer extends StatelessWidget {
  final Item item;

  MyContainer({required this.item});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Set container size based on screen width
    double containerWidth = screenWidth * 0.40; // 40% of screen width
    double containerHeight = screenWidth * 0.5; // 50% of screen width

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlantInfoScreen(plantName: item.text),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 10, right: 2, left: 2), // Adjusted margin
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // Position shadow on right and bottom
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      width: containerWidth * 0.67,
                      height: containerHeight * 0.48,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: Text(
                    item.text,
                    textAlign: TextAlign.center,
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
