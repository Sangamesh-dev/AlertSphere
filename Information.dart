import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  final String name;
  final String phone;

  // Constructor to receive initial values for name and phone
  PersonalInfoPage({required this.name, required this.phone});

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;  // Initialize with passed name
    phoneController.text = widget.phone;  // Initialize with passed phone
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),

            // Phone number
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),

            // Save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color of the button
                foregroundColor: Colors.white, // Text color of the button
              ),
              onPressed: () {
                String updatedName = nameController.text;
                String updatedPhone = phoneController.text;

                // Return the updated information to the AboutPage
                Navigator.pop(context, {
                  'name': updatedName,
                  'phone': updatedPhone,
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Saved successfully!')),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
