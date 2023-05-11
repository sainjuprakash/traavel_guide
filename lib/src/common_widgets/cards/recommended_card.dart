import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../features/authentication/models/place_modal.dart';

class RecommendedCard extends StatelessWidget {
  final PlaceInfo placeInfo;
  final VoidCallback press;
  const RecommendedCard({
    super.key,
    required this.placeInfo,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return InkWell(
      onTap: press,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 250,
          width: 200,
          decoration: BoxDecoration(
              color: isDark ? tSecondaryClr : tCardBgClr,
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(placeInfo.image))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  placeInfo.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: tPrimaryClr,
                    ),
                    Text(
                      placeInfo.location,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
