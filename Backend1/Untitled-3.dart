import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Home.dart'; // Import HomePage for navigation
import 'Weather.dart'; // Import WeatherPage for navigation
import 'About.dart'; // Import AboutPage for navigation

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _selectedIndex = 2; // Default selected index for NewsPage
  TextEditingController _cityController = TextEditingController();
  List<dynamic> _articles = [];
  String _errorMessage = '';

  // Replace with your News API key
  final String apiKey = 'a613687bd7e14dbfa4263426f9b61010';

  Future<void> _fetchNews(String city) async {
    final String query = '$city flood OR $city rain';
    final String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if the response contains articles
        if (data['articles'] != null) {
          setState(() {
            _articles = data['articles'];
            _errorMessage = '';
          });
        } else {
          setState(() {
            _articles = [];
            _errorMessage = 'No articles found for $city.';
          });
        }
      } else {
        setState(() {
          _articles = [];
          _errorMessage = 'Failed to load news. Please try again later.';
        });
      }
    } catch (e) {
      setState(() {
        _articles = [];
        _errorMessage = 'Error: $e';
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WeatherPage()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutPage()),
      );
    }
  }

  void _openArticleDetails(Map<String, dynamic> article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArticleDetailsPage(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'News Search',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: 'Enter city name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      _fetchNews(_cityController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
                : Expanded(
              child: _articles.isNotEmpty
                  ? ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: article['urlToImage'] != null
                          ? Image.network(
                        article['urlToImage'],
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                          : Icon(Icons.image, size: 60),
                      title: Text(article['title'] ?? 'No Title'),
                      subtitle: Text('Published on: ${article['publishedAt'] ?? 'Unknown'}'),
                      onTap: () => _openArticleDetails(article),
                    ),
                  );
                },
              )
                  : Center(child: Text('No articles found')),
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

class ArticleDetailsPage extends StatelessWidget {
  final Map<String, dynamic> article;

  ArticleDetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article['urlToImage'] != null)
              Image.network(article['urlToImage']),
            SizedBox(height: 16),
            Text(
              article['title'] ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Published on: ${article['publishedAt'] ?? 'Unknown'}',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              article['description'] ?? 'No Description Available',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
