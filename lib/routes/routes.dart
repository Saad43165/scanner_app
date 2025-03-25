import 'package:flutter/material.dart';

import '../screens/authScreens/forgetpassword.dart';
import '../screens/authScreens/loginScreen.dart';
import '../screens/authScreens/registerScreen.dart';
import '../screens/mainScreens/dashbaord.dart';
import '../screens/mainScreens/documents/MedicineUI.dart';
import '../screens/mainScreens/documents/ScanDocScreen.dart';
import '../screens/mainScreens/documents/docMainScreen.dart';
import '../screens/splashscreens/auth_options_screen.dart';
import '../screens/splashscreens/splashScreen.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String authOption = '/authOption';
  static const String dashboard = '/dashboard';
  static const String Splash = '/splash';
  static const String MyDoc = '/mydocmain';
  static const String ScanDocScreen = '/scandocscreen';
  static const String MedicineDetial = '/medidetail';
  static const String forgetpass = '/forgetpassword';
  static const String profile = '/profile'; // ✅ Profile route without import

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case ScanDocScreen:
        return MaterialPageRoute(builder: (_) => ScanDocumentScreen());
      case forgetpass:
        return MaterialPageRoute(builder: (_) => ForgetPass_screen());
      case MedicineDetial:
        return MaterialPageRoute(builder: (_) => MedicineScanPage());
      case MyDoc:
        return MaterialPageRoute(builder: (_) => DocumentScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case authOption:
        return MaterialPageRoute(builder: (_) => auth_options_screen());
      case dashboard:
        return MaterialPageRoute(builder: (_) => Dashboard());

      case profile: // ✅ Profile route handler without import
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => _buildProfileScreen(args), // ✅ Using function to create ProfileScreen
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  // ✅ Function to create ProfileScreen without importing directly
  static Widget _buildProfileScreen(Map<String, String> args) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileInfo('Full Name', args['fullName'] ?? 'N/A'),
            _buildProfileInfo('Email', args['email'] ?? 'N/A'),
            _buildProfileInfo('Phone Number', args['phoneNumber'] ?? 'N/A'),
            _buildProfileInfo('User Type', args['userType'] ?? 'N/A'),
          ],
        ),
      ),
    );
  }

  // ✅ Helper widget for Profile Information
  static Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
