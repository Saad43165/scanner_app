import 'package:flutter/material.dart';
import '../../../consts/themes.dart';

class ProfileHelpers {
  static void editProfile(BuildContext context, Map<String, dynamic> args) {
    Navigator.pushNamed(
      context,
      '/register',
      arguments: args,
    );
  }

  static void showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            'Confirm Logout',
            style: TextStyle(
              fontFamily: 'Oregano',
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontFamily: 'Oregano',
              fontSize: 16.0,
              color: AppColors.textDark,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Oregano',
                  color: AppColors.primary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Oregano',
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static PopupMenuItem<String> buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        bool isDestructive = false,
      }) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(icon,
              color: isDestructive ? Colors.red[400] : AppColors.primary,
              size: 22),
          const SizedBox(width: 12),
          Text(label,
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16,
                color: isDestructive ? Colors.red[400] : AppColors.textDark,
              )),
        ],
      ),
    );
  }
}