import 'package:flutter/material.dart';
import '../screens/authScreens/forgetpassword.dart';
import '../screens/authScreens/loginScreen.dart';
import '../screens/authScreens/registerScreen.dart';
import '../screens/mainScreens/DashboardScreen/dashbaord.dart' show Dashboard;
import '../screens/mainScreens/ProfileScreen/profile_screen.dart';
import '../screens/mainScreens/documents/MedicineScreen/medicine_scan_screen.dart';
import '../screens/mainScreens/documents/ScanDocScreen.dart';
import '../screens/mainScreens/documents/docMainScreen.dart';
import '../screens/splashscreens/auth_options_screen.dart';
import '../screens/splashscreens/splashScreen.dart';// ✅ Import ProfileScreen

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
  static const String profile = '/profile'; // ✅ Profile route

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
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => Dashboard(userData: args),
        );

      case profile:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(
            fullName: args?['fullName'] ?? '',
            email: args?['email'] ?? '',
            phoneNumber: args?['phoneNumber'] ?? '',
            userType: args?['userType'] ?? 'Normal User' ?? 'Doctor',
          ),
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
}
