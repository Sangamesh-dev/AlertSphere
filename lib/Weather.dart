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
    final apiKey = 'c981a79545a643d183a14ee6caf9b74d'; // Replace with your actual API key
    final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _city = data['name'];
          _temperature = '${data['main']['temp'].toInt()}°C';
          _weatherCondition = data['weather'][0]['description'].toUpperCase();
          _description = 'Feels like ${data['main']['feels_like'].toInt()}°C, ${data['weather'][0]['description']}';
        });
      } else {
        setState(() {
          _weatherCondition = 'Error Fetching Weather';
          _description = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      print('Error: $e'); // Log the error
      setState(() {
        _weatherCondition = 'Network Error';
        _description = 'Please check your connection.';
      });
    }
  }

  String _generateWeatherPrompt(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains("clear")) {
      return "It's a perfect day to step out and enjoy the sunshine!";
    } else if (condition.contains("rain")) {
      return "Grab your umbrella! It's going to be a rainy day.";
    } else if (condition.contains("cloud")) {
      return "A calm and cloudy day awaits. Enjoy the cool weather.";
    } else if (condition.contains("snow")) {
      return "Snow is falling! Time to bundle up and stay cozy.";
    } else if (condition.contains("wind")) {
      return "Hold on to your hats, it's quite breezy out there!";
    } else if (condition.contains("fog") || condition.contains("mist")) {
      return "Drive carefully, visibility might be low due to the fog.";
    } else if (condition.contains("storm")) {
      return "Stay indoors if you can; there's a storm brewing!";
    } else if (condition.contains("hot")) {
      return "It's a scorcher! Keep cool and stay hydrated.";
    } else if (condition.contains("humid")) {
      return "It's humid and sticky. Stay in the shade if you can.";
    } else {
      return "Weather is unpredictable today. Stay prepared!";
    }
  }

  Color getWeatherColor(String condition) {
    condition = condition.toLowerCase();

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = getWeatherColor(_weatherCondition);
    String promptText = _generateWeatherPrompt(_weatherCondition);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 400),
                  painter: WavePainter(backgroundColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promptText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
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
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
                          style: TextStyle(fontSize: 24, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      _description,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
    Paint paint = Paint()..color = color;
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
