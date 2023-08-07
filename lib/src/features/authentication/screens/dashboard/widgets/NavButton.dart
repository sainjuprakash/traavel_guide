import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    this.onPress,
    this.icon,
    this.color,
  });
  final onPress;
  final icon;
  final color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: Icon(
        icon,
        size: 30,
        color: color,
      ),
      // onPressed:onPress () => Get.to(ProfileScreen()),
      // icon: Icon(Icons.person_outline, size: 30),
    );
  }
}
