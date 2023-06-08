import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../models/place_modal.dart';

class DetailScreen extends StatelessWidget {
  final PlaceInfo placeInfo;
  const DetailScreen({Key? key, required this.placeInfo}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        backgroundColor: tWhiteClr,
        body: Stack(
          children: [
            Image.network(placeInfo.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.5),
            SafeArea(
                child: Column(
              children: [
                /********APPBAR_BUTTON**********/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(100),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_back,
                                color: isDark ? tPrimaryClr : tDarkClr,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            height: 25,
                            width: 25,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(15),
                            //   // boxShadow: [
                            //   //   BoxShadow(
                            //   //     color: Colors.black26,
                            //   //     blurRadius: 6,
                            //   //   )
                            //   //]
                            // ),
                            child: Icon(
                              Icons.favorite,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isDark ? tSecondaryClr : tWhiteClr,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              placeInfo.name,
                              style: TextStyle(
                                  color: isDark ? tPrimaryClr : tSecondaryClr,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: tPrimaryClr,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(placeInfo.address,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Temple Details",
                              style: TextStyle(
                                  color: isDark ? tPrimaryClr : tSecondaryClr,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(placeInfo.desc,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                )),
                            Divider(
                              height: 5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("city",
                                    style: TextStyle(
                                      color:
                                          isDark ? tPrimaryClr : tSecondaryClr,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text("${placeInfo.city} city",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.grey
                                            : tSecondaryClr,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Deity",
                                    style: TextStyle(
                                      color:
                                          isDark ? tPrimaryClr : tSecondaryClr,
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text("${placeInfo.city} god",
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.grey
                                            : tSecondaryClr,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              color: tPrimaryClr,
                              minWidth: double.infinity,
                              height: 55,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              onPressed: () {},
                              child: Text(
                                "Book Trip",
                                style: TextStyle(
                                    color: isDark ? tDarkClr : tWhiteClr,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
