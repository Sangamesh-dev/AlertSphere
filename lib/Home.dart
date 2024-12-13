import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'Weather.dart'; // Import the Weather page
import 'News.dart'; // Import the News page
import 'About.dart'; // Import the About page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic for the BottomNavigationBar
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Decode the Base64 string
    String base64Image = 'https://tinyurl.com/yhdamfbf';
    Uint8List imageBytes = base64Decode(base64Image);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                // User Greeting Section
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Good Morning USER!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Map Placeholder
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.map,
                      size: 100,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Location and Temperature Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.black),
                    SizedBox(width: 5),
                    Text('Bangalore', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud, color: Colors.black),
                    SizedBox(width: 5),
                    Text('25°C', style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(height: 20),
                // Notifications Section
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://via.placeholder.com/50',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          title: Text('Notification Title'),
                          subtitle: Text(
                            'Laborum aliqua do mollit nostrud irure sit nulla duis nisi nulla est...',
                          ),
                          trailing: Icon(Icons.circle, color: Colors.blue, size: 12),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Alena Chatbot Button Positioned on the Right Side Above the Column
          Positioned(
            bottom: 10,
            right: 20,
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: ClipOval(
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Alena',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}