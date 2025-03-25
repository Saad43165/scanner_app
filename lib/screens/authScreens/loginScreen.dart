import 'package:flutter/material.dart';
import '../../consts/themes.dart';
import '../../consts/custombackbutton.dart';

class LoginScreen extends StatelessWidget {
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

                // Reusable Back Button (Sending Data Back)
                CustomBackButton(
                  iconColor: Colors.black,
                  backgroundColor: Colors.white,
                  iconSize: 28.0,
                  dataToPassBack: "Data from LoginScreen", // Data to pass back
                ),

                SizedBox(height: Responsive.height(context) * 0.03),

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

                SizedBox(height: Responsive.height(context) * 0.03),

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
                    'Go to Dashboard',
                    style: TextStyle(
                      fontSize: Responsive.textSize(context, 18),
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
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
