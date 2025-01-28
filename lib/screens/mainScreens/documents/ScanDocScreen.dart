import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../consts/bottomNavbar.dart'; // Replace with the correct import path for AnimatedNavBar

class ScanDocumentScreen extends StatefulWidget {
  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen> {
  int _selectedIndex = 1; // Set the default index to 1 for the "Scan" page
  File? _image; // Variable to store the selected image
  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update state with the selected image
      });
    }
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation logic
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard'); // Navigate to Home page
        break;
      case 1:
      // Stay on the current Scan page
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile'); // Navigate to Profile page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedNavBar(
        onTap: _onNavBarTapped,
        currentIndex: _selectedIndex,
      ),
      appBar: AppBar(
        title: Text("Scan Document"),
        centerTitle: true,
        backgroundColor: Color(0xFF303F9F), // Navy blue color for the app bar
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF303F9F), // Navy blue background
              child: Center(
                child: Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: _image != null
                        ? Image.file(
                      _image!, // Display the selected image
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      'https://via.placeholder.com/300x400', // Placeholder
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                Text(
                  "You can add something",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF303F9F), // Navy text color
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/medidetail');
                      }, // Add functionality for documents if needed
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange, // Orange box for the icon
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.file_present, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Document",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303F9F),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage, // Function to pick image
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue, // Orange box for the icon
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.photo_library, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          const Text(
                            "Gallery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303F9F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
