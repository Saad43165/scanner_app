import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../consts/bottomNavbar.dart';

class ScanDocumentScreen extends StatefulWidget {
  final Map<String, dynamic>? userData; // Accept userData as arguments

  const ScanDocumentScreen({Key? key, this.userData}) : super(key: key);

  @override
  State<ScanDocumentScreen> createState() => _ScanDocumentScreenState();
}

class _ScanDocumentScreenState extends State<ScanDocumentScreen> {

  int _selectedIndex = 1;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _onNavBarTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    final userData = widget.userData;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
          arguments: userData,
        );
        break;
      case 1:
        break; // Stay on the current Scan page
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/profile',
          arguments: userData,
        );
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
        automaticallyImplyLeading: false,
        title: Text("Scan Document",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Color(0xFF303F9F),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFF303F9F),
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
                      _image!,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      'https://via.placeholder.com/300x400',
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
                    color: Color(0xFF303F9F),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/medidetail',
                          arguments: widget.userData,
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.orange,
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
                      onTap: _pickImage,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.photo_library, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Text(
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
