import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Dash extends StatefulWidget {
  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  static List<dynamic> data = []; // List to store fetched data

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.109:80/api/show_user_from_db.php'));
    // print('hello${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        print('hello${response.statusCode}');
        data = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('show user hjhggjginfo'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            title: Text('1'),
            subtitle: Column(
              children: [
                Text('username: ${item['Name']}'),
                Text('Email: ${item['Country']}'),
                //Text('Address: ${item['Description']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
