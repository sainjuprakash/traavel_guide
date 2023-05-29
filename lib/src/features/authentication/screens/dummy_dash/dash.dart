import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Item {
  final String name;
  final String imageUrl;

  Item({required this.name, required this.imageUrl});
}

class Dash extends StatefulWidget {
  final String category;

  const Dash({Key? key, required this.category}) : super(key: key);

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final apiKey = 'Your_API_KEy';
    final location =
        '27.672845084463354, 85.42860344085487'; // Example: '40.7128,-74.0060'
    final radius = '5000'; // Example: '5000' (5km radius)
    final type = widget.category; // Example: 'restaurant'

    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$location&radius=$radius&type=$type&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];

      setState(() {
        items = results.map<Item>((place) {
          final name = place['name'];
          final photoReference = place['photos'][0]['photo_reference'];
          final imageUrl =
              'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';

          return Item(name: name, imageUrl: imageUrl);
        }).toList();
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Image.network(item.imageUrl),
            title: Text(item.name),
          );
        },
      ),
    );
  }
}
