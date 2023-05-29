import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/features/authentication/controllers/profile_controller.dart';
import 'package:login_setup/src/features/authentication/models/user_model.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final controller = Get.put(ProfileController());
  //String? _mapStyle;
  // @override
  // void initState() {
  //   super.initState();

  //   rootBundle.loadString('assets/images/map_style.txt').then((string) {
  //     _mapStyle = string;
  //   });
  // }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.672845084463354, 85.42860344085487),
    zoom: 14.4746,
  );
  GoogleMapController? myMapController;

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 150,
          left: 0,
          right: 0,
          bottom: 0,
          child: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
                //myMapController!.setMapStyle(_mapStyle);
              },
              initialCameraPosition: _kGooglePlex,
              markers: {
                Marker(
                  markerId: MarkerId('location'),
                  position: LatLng(27.672845084463354, 85.42860344085487),
                ),
              }),
        ),
        buildProfileTile(controller, isDark),
        //placesAutoCompleteTextField(),
        buildTextField(isDark),
        buildCurrentLocationIcon(isDark),
        buildNotificationIcon(),
        buildBottomSheet(),
      ]),
    );
  }
}

Widget buildTextField(bool isDark) {
  TextEditingController controller = TextEditingController();
  return Positioned(
    top: 170,
    left: 20,
    right: 20,
    child: Container(
      width: Get.width,
      height: 50,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isDark ? tSecondaryClr : tWhiteClr,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 10,
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "Your_APi_key",
        inputDecoration: InputDecoration(
          hintStyle: TextStyle(
            color: isDark ? tCardBgClr : tDarkClr,
          ),
          hintText: 'Search for a destination',
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: isDark ? tCardBgClr : tDarkClr,
            ),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 800, // default 600 ms
        countries: ["NP"], // optional: restrict results to specific countries
        isLatLngRequired: true, // if you require coordinates from place detail
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // This method will return latlng with place detail
          print("Place details:");
          print("PlaceId:${prediction.placeId}");
          print("Types:${prediction.types}");
          print("Description: ${prediction.description}");
          print("Latitude: ${prediction.lat}");
          print("Longitude: ${prediction.lng}");
        }, // this callback is called when isLatLngRequired is true
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description!.length),
          );
        },
      ),
    ),
  );
}

Widget buildProfileTile(controller, isDark) {
  return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // User data is available
                UserModel user = snapshot.data as UserModel;
                final fullname = TextEditingController(text: user.fullname);

                return Container(
                  width: Get.width,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/user.png"),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Good Morning, ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14)),
                              TextSpan(
                                  text: fullname.text,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ])),
                            Text(
                              "Where are you going?",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        )
                      ]),
                );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  ],
                );
              } else {
                // Data is still loading
                return Center(child: CircularProgressIndicator());
              }
            } else {
              // Data is still loading
              return Center(child: CircularProgressIndicator());
            }
          }));
}

Widget buildCurrentLocationIcon(bool isDark) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 8),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: isDark ? tPrimaryClr : Colors.green,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.my_location,
            color: tWhiteClr,
          ),
        ),
      ),
    ),
  );
}

Widget buildNotificationIcon() {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 8),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.notifications,
          color: Color(0xffC3CDD6),
        ),
      ),
    ),
  );
}

Widget buildBottomSheet() {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: Get.width * 0.8,
      height: 25,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 4,
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Center(
          child: Container(
        width: Get.width * 0.6,
        height: 4,
        color: Colors.black45,
      )),
    ),
  );
}
