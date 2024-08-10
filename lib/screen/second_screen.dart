import 'package:flutter/material.dart';
import 'package:mobile_test/provider/palindrome_provider.dart'; // Pastikan path benar
import 'package:provider/provider.dart';

import 'third_screen.dart'; // Pastikan path benar

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Consumer<PalindromeProvider>(
              builder: (context, palindromeProvider, child) => Text(
                palindromeProvider.name.isNotEmpty
                    ? palindromeProvider.name
                    : 'Belum ada nama',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 220.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Selected User Name',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ThirdScreen(),
              ),
            );
          },
          child: Text('Choose a User'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF2b637b),
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ),
    );
  }
}
