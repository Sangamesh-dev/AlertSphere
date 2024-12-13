import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, String>> _messages = [];

  Future<void> _sendMessage(String userMessage) async {
    setState(() {
      _messages.add({"sender": "user", "text": userMessage});
    });
    _textController.clear();

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/chat'), // Replace with your API endpoint
        headers: {"Content-Type": "application/json"},
        body: json.encode({"message": userMessage}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages.add({"sender": "bot", "text": data['response']});
        });
      } else {
        throw Exception("Failed to get a response from the server");
      }
    } catch (e) {
      setState(() {
        _messages.add({"sender": "bot", "text": "Error: ${e.toString()}"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message['sender'] == 'user'
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message['text'] ?? ""),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(_textController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}