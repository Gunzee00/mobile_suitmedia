import 'package:flutter/material.dart';
import 'package:mobile_test/provider/palindrome_provider.dart';
import 'package:mobile_test/provider/user_provider.dart';
import 'package:mobile_test/screen/first_screen.dart';
import 'package:mobile_test/screen/second_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PalindromeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}
