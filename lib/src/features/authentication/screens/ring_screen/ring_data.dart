import 'package:flutter/material.dart';
import 'ripple_Animation.dart';

class RingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rings'),
      ),
      body: Center(
        child: RingsWidget(),
      ),
    );
  }
}
