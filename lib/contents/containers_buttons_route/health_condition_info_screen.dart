import 'package:flutter/material.dart';

class PlantInfoScreen extends StatelessWidget {
  final String plantName;

  PlantInfoScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plantName),
        backgroundColor: Colors.green, // Customize the AppBar color if needed
      ),
      body: Center(
        child: Text(
          'Details about $plantName',
          style: TextStyle(fontSize: 4),
        ),
      ),
    );
  }
}
