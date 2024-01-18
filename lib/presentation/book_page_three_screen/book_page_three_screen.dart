import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  String imageUrl = ''; // Initialize with an empty string
  bool isDatabaseConnected = true; // Assume connected initially

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      print('hi');
      // TODO: Change the IP address to your own machine's IP address
      final response =
      await http.get(Uri.parse('http://192.168.0.96:5000/api/first_book_image'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // Print the image URL
        print('Image URL: ${data['image_url']}');

        if (mounted) {
          setState(() {
            imageUrl = data['image_url'];
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isDatabaseConnected = false;
          });
        }
      }
    } catch (error) {
      print('Error: $error');
      if (mounted) {
        setState(() {
          isDatabaseConnected = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Image URL'),
      ),
      body: Center(
        child: isDatabaseConnected
            ? imageUrl.isNotEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 200, // Set the desired height
              width: 200, // Set the desired width
              fit: BoxFit.contain, // Adjust the fit as needed
            ),
            SizedBox(height: 16),
            Text('Image URL: $imageUrl'),
          ],
        )
            : Text('No image available')
            : Text('Database not connected'),
      ),
    );
  }
}
