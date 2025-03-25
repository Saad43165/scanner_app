import 'package:flutter/material.dart';
import '../../consts/themes.dart';
import '../../consts/custombackbutton.dart'; // Importing the reusable back button

class ForgetPass_screen extends StatelessWidget {
  const ForgetPass_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width(context) * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: Responsive.height(context) * 0.03),

                // Reusable Back Button
                const CustomBackButton(
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 28.0,
                ),

                SizedBox(height: Responsive.height(context) * 0.03),

                // App Title
                Center(
                  child: Text(
                    'MediVision',
                    style: TextStyle(
                      fontFamily: 'AbrilFatface',
                      fontSize: Responsive.textSize(context, 28),
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.height(context) * 0.01),

                // App Subtitle
                Center(
                  child: Text(
                    'from scribbles to digital',
                    style: TextStyle(
                      fontSize: Responsive.textSize(context, 14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Info Text
                Text(
                  'Enter your correct email address to receive a password reset email',
                  style: TextStyle(
                    fontSize: Responsive.textSize(context, 14),
                    color: Colors.blueGrey,
                  ),
                ),

                SizedBox(height: 80),

                // Email Address Label
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: Responsive.textSize(context, 14),
                    color: Colors.blueGrey,
                  ),
                ),

                SizedBox(height: Responsive.height(context) * 0.01),

                // Email Input Field
                const TextField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),

                SizedBox(height: Responsive.height(context) * 0.03),

                // Continue Button
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: Responsive.textSize(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),

                SizedBox(height: Responsive.height(context) * 0.05),
                SizedBox(height: Responsive.height(context) * 0.05),

                // Create Account Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New User? ',
                        style: TextStyle(
                          fontSize: Responsive.textSize(context, 12),
                          color: AppColors.textDark,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: AppColors.navy,
                            fontSize: Responsive.textSize(context, 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
