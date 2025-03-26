import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medi_vision_app/routes/routes.dart';
import 'package:medi_vision_app/consts/themes.dart';
import 'package:medi_vision_app/screens/menu/notification_provider.dart'; // Make sure to import your NotificationProvider

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        // Add other providers here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.Splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}