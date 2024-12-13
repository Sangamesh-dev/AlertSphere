import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home.dart'; // Import HomePage for navigation
import 'News.dart'; // Import NewsPage for navigation
import 'About.dart'; // Import AboutPage for navigation

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int _selectedIndex = 1; // Default selected index for WeatherPage
  TextEditingController _cityController = TextEditingController();
  String _city = 'Berlin';
  String _weatherCondition = 'CLEAR SKY';
  String _temperature = '5°';
  String _description = 'Clear sky with pleasant weather';

  // Color mapping for different weather conditions
  Map<String, Color> weatherColors = {
    'clear': Colors.blue, // Clear Sky
    'cloudy': Colors.grey, // Cloudy
    'rain': Colors.blueGrey, // Rainy
    'storm': Colors.deepPurple, // Stormy
    'snow': Colors.white, // Snowy
    'wind': Colors.lightBlueAccent, // Windy
    'fog': Colors.blueGrey[700]!, // Foggy
    'hot': Colors.red, // Hot
    'humid': Colors.orange, // Humid
    'default': Colors.blue, // Default color
  };

  @override
  void initState() {
    super.initState();
    _fetchWeather(_city);
  }

  void _fetchWeather(String city) async {
    final apiKey = '038bba3b63ca4ea29e0a886419119be4';
    final apiUrl = 'https://api.weatherbit.io/v2.0/current?city=$city&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _city = data['data'][0]['city_name'];
          _temperature = '${data['data'][0]['temp'].toInt()}°C';
          _weatherCondition = data['data'][0]['weather']['description'].toUpperCase();
          _description = 'Feels like ${data['data'][0]['app_temp']}°C, ${data['data'][0]['weather']['description']}';
        });
      } else {
        setState(() {
          _weatherCondition = 'Error fetching weather';
        });
      }
    } catch (e) {
      setState(() {
        _weatherCondition = 'Network Error';
      });
    }
  }

  Color getWeatherColor(String condition) {
    condition = condition.toLowerCase(); // Make the condition lowercase for consistent matching

    if (condition.contains("rain")) {
      return weatherColors['rain']!;
    } else if (condition.contains("clear")) {
      return weatherColors['clear']!;
    } else if (condition.contains("cloud") || condition.contains("overcast")) {
      return weatherColors['cloudy']!;
    } else if (condition.contains("snow")) {
      return weatherColors['snow']!;
    } else if (condition.contains("wind") || condition.contains("breeze")) {
      return weatherColors['wind']!;
    } else if (condition.contains("fog") || condition.contains("mist")) {
      return weatherColors['fog']!;
    } else if (condition.contains("storm") || condition.contains("thunder")) {
      return weatherColors['storm']!;
    } else if (condition.contains("hot") || condition.contains("heat")) {
      return weatherColors['hot']!;
    } else if (condition.contains("humid")) {
      return weatherColors['humid']!;
    } else {
      return weatherColors['default']!;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate back to HomePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 2) {
      // Navigate to NewsPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewsPage()),
      );
    } else if (index == 3) {
      // Navigate to AboutPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getWeatherColor(_weatherCondition);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onSubmitted: (value) {
                  _fetchWeather(value);
                },
              ),
            ),
            // Custom Wave Section with Weather Condition
            Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 400),
                  painter: WavePainter(backgroundColor), // Pass the color here
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'nah, stay\ninside, it\'s',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        _weatherCondition,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'today.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Weather Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _city.toLowerCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          _temperature,
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'C',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      _description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Arrow Navigation Button
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Implement any action when the button is clicked
                    print('Navigate to detailed weather page');
                  },
                ),
              ),
            ),
          ],
        ),
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

// Custom Painter for the wave design
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color; // Use the passed color
    Path path = Path();

    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height - 50,
    );
    path.quadraticBezierTo(
      3 * size.width / 4,
      size.height - 100,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}