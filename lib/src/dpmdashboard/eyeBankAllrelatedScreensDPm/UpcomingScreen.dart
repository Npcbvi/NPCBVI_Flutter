import 'package:flutter/material.dart';

class UpcomingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon',
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),),

        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          'Upcoming screen soon',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
