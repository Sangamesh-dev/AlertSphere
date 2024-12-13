import 'package:flutter/material.dart';

// Personal Info screen with editable text fields and a Save button
class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // Controllers for each field
  TextEditingController nameController = TextEditingController(text: 'John Doe');
  TextEditingController dobController = TextEditingController(text: '1st January 1990');
  TextEditingController emailController = TextEditingController(text: 'johndoe@example.com');
  TextEditingController phoneController = TextEditingController(text: '(929) 617-0714'); // New Phone Controller
  TextEditingController locationController = TextEditingController(text: 'New York, USA');
  TextEditingController genderController = TextEditingController(text: 'Male');

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

            // DOB
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(
                labelText: 'DOB',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),

            // Email
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),

            // Phone Number
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
            SizedBox(height: 10),

            // Location
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 10),

            // Gender
            TextFormField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
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
                // Handle save action
                String name = nameController.text;
                String dob = dobController.text;
                String email = emailController.text;
                String phone = phoneController.text; // Get phone number
                String location = locationController.text;
                String gender = genderController.text;

                // Show a confirmation or save the data
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Saved successfully!')),
                );

                // For now, just print the data to console
                print('Name: $name');
                print('DOB: $dob');
                print('Email: $email');
                print('Phone: $phone'); // Print phone number
                print('Location: $location');
                print('Gender: $gender');
              },
              child: Text('Save'),
            )

          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {
              // Handle QR Code button action if needed
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit button action if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: ClipOval(
                child: Image.network(
                  'https://www.iconfinder.com/icons/403022/business_man_male_user_avatar_profile_person_man_icon',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'John',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '(929) 617-0714', // Updated to show phone number
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Personal Information'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to Personal Info screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.security),
                    title: Text('Privacy & Security'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Add navigation logic here if needed
                      print('Navigate to Privacy & Security page');
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.headset_mic),
                    title: Text('Support'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Add navigation logic here if needed
                      print('Navigate to Support page');
                    },
                  ),
                  Divider(),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200, // Changed from 'primary'
                foregroundColor: Colors.black, // Changed from 'onPrimary'
              ),
              onPressed: () {
                // Handle logout action
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
