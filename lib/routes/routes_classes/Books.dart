import 'package:flutter/material.dart';

class Books extends StatelessWidget {
  const Books({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // I want to have 5 variables, title, author, isbn, publisher, year
    return Scaffold(
      appBar: AppBar(
        title: Text('Books'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Title'),
            Text('Author'),
            Text('ISBN'),
            Text('Publisher'),
            Text('Year'),
          ],
        ),
      ),
    );
    }
}