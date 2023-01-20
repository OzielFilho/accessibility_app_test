import 'package:flutter_app/src/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Accessibility App Test',
      home: const HomePage(),
      theme: ThemeData(
          backgroundColor: Colors.black,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.pink[600]),
      initialRoute: '/',
    );
  }
}
