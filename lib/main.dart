import 'package:flutter/material.dart';
import 'package:medi_vision_app/routes/routes.dart';

import 'consts/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.Splash, // Set the initial route
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

