import 'package:flutter/material.dart';

import '../../consts/themes.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purple[100],
                    child: Icon(Icons.qr_code_scanner,
                        size: 50, color: AppColors.primary),
                  ),
                ),
                SizedBox(height: 40),
                // Full Name
                Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Nabeel Tahir',
                    hintStyle: TextStyle(color: AppColors.navy,fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Email Address
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'nabeeltahir@gmail.com',
                    hintStyle: TextStyle(color: AppColors.navy,fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Phone Number
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 100,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'PK +92',
                          hintStyle: TextStyle(color: AppColors.navy,fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        enabled: false,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Phone Number',
                          hintStyle: TextStyle(color: AppColors.navy,fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Password
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter New Password',
                    hintStyle: TextStyle(color: AppColors.navy,fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 80),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 60.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
