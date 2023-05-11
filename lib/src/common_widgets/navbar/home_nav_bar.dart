import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/screens/profile/profile_screen.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  @override
  _HomeNavBarState createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      index: 2,
      items: [
        IconButton(
          onPressed: () => Get.to(ProfileScreen()),
          icon: Icon(Icons.person_outline, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_outline, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.home, size: 30, color: Colors.redAccent),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.location_on_outlined, size: 30),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.list, size: 30),
        ),
      ],
    );
  }
}
