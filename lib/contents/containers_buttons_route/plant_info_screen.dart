import 'package:flutter/material.dart';
import '../../database/database_helper.dart';  // Import the database helper

class PlantInfoScreen extends StatelessWidget {
  final String plantName;

  PlantInfoScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plantName)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getPlantInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No information available.'));
          } else {
            final plant = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Name: ${plant['name']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description: ${plant['description']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  plant['image'] != null
                      ? Image.asset(plant['image'])
                      : SizedBox.shrink(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getPlantInfo() async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'plants',
      where: 'name = ?',
      whereArgs: [plantName],
    );
    return result.isNotEmpty ? result.first : {};
  }
}
