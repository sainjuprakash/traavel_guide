// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:login_setup/src/constants/colors.dart';

// // class MapScreen extends StatefulWidget {
// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   late GoogleMapController mapController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Google MAPS'),
// //       ),
// //       body: GoogleMap(
// //         onMapCreated: _onMapCreated,
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(37.7749, -122.4194),
// //           zoom: 12,
// //         ),
// //       ),
// //     );
// //   }

// //   void _onMapCreated(GoogleMapController controller) {
// //     setState(() {
// //       mapController = controller;
// //     });
// //   }
// // }

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   String? _mapStyle;
//   @override
//   void initState() {
//     super.initState();

//     rootBundle.loadString('assets/images/map_style.txt').then((string) {
//       _mapStyle = string;
//     });
//   }

//   final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   GoogleMapController? myMapController;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps'),
//       ),
//       body: Stack(children: [
//         Positioned(
//           top: 150,
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: GoogleMap(
//             zoomControlsEnabled: false,
//             onMapCreated: (GoogleMapController controller) {
//               myMapController = controller;
//               myMapController!.setMapStyle(_mapStyle);
//             },
//             initialCameraPosition: _kGooglePlex,
//           ),
//         ),
//         buildProfileTile(),
//         buildTextField(),
//         buildCurrentLocationIcon(),
//         buildNotificationIcon(),
//         buildBottomSheet(),
//       ]),
//     );
//   }
// }

// TextEditingController controller = TextEditingController();
// Future<TextSelection> showGoogleAutoComplete() async {
//   GooglePlaceAutoCompleteTextField(
//       textEditingController: controller,
//       googleAPIKey: "AIzaSyDqBLIeqvYVoqCAXm-MsrSQ4P",
//       inputDecoration: InputDecoration(),
//       debounceTime: 800, // default 600 ms,
//       countries: ["in", "fr"], // optional by default null is set
//       isLatLngRequired: true, // if you required coordinates from place detail
//       getPlaceDetailWithLatLng: (Prediction? prediction) {
//         // this method will return latlng with place detail
//         print("placeDetails" + prediction!.lng.toString());
//       }, // this callback is called when isLatLngRequired is true
//       itmClick: (Prediction? prediction) {
//         controller.text = prediction!.description!;
//         controller.selection = TextSelection.fromPosition(
//             TextPosition(offset: prediction.description!.length));
//       });
//   return controller.selection;
// }

// Widget buildTextField() {
//   return Positioned(
//     top: 170,
//     left: 20,
//     right: 20,
//     child: Container(
//         width: Get.width,
//         height: 50,
//         padding: EdgeInsets.only(left: 15),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   spreadRadius: 4,
//                   blurRadius: 10)
//             ],
//             borderRadius: BorderRadius.circular(8)),
//         child: TextFormField(
//           readOnly: true,
//           onTap: () {
//             showGoogleAutoComplete();
//           },
//           style: GoogleFonts.poppins(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Color(0xffA7A7A7),
//           ),
//           decoration: InputDecoration(
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 16, fontWeight: FontWeight.bold),
//               hintText: 'Search for a destination',
//               suffixIcon: Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: Icon(Icons.search),
//               ),
//               border: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               enabledBorder: InputBorder.none),
//         )),
//   );
// }

// Widget buildProfileTile() {
//   return Positioned(
//       top: 60,
//       left: 20,
//       right: 20,
//       child: Container(
//         width: Get.width,
//         child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 60,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/user.png"),
//                         fit: BoxFit.fill)),
//               ),
//               SizedBox(
//                 width: 15,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   RichText(
//                       text: TextSpan(children: [
//                     TextSpan(
//                         text: 'Good Morning, ',
//                         style: TextStyle(color: Colors.black, fontSize: 14)),
//                     TextSpan(
//                         text: 'Sijal',
//                         style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold))
//                   ])),
//                   Text(
//                     "Where are you going?",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   )
//                 ],
//               )
//             ]),
//       ));
// }

// Widget buildCurrentLocationIcon() {
//   return Align(
//     alignment: Alignment.bottomRight,
//     child: Padding(
//       padding: const EdgeInsets.only(bottom: 30, right: 8),
//       child: CircleAvatar(
//         radius: 20,
//         backgroundColor: Colors.green,
//         child: Icon(
//           Icons.my_location,
//           color: tWhiteClr,
//         ),
//       ),
//     ),
//   );
// }

// Widget buildNotificationIcon() {
//   return Align(
//     alignment: Alignment.bottomLeft,
//     child: Padding(
//       padding: const EdgeInsets.only(bottom: 30, right: 8),
//       child: CircleAvatar(
//         radius: 20,
//         backgroundColor: Colors.white,
//         child: Icon(
//           Icons.notifications,
//           color: Color(0xffC3CDD6),
//         ),
//       ),
//     ),
//   );
// }

// Widget buildBottomSheet() {
//   return Align(
//     alignment: Alignment.bottomCenter,
//     child: Container(
//       width: Get.width * 0.8,
//       height: 25,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 spreadRadius: 4,
//                 blurRadius: 10)
//           ],
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(12), topLeft: Radius.circular(12))),
//       child: Center(
//           child: Container(
//         width: Get.width * 0.6,
//         height: 4,
//         color: Colors.black45,
//       )),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? _mapController;
  final LatLng _target = LatLng(27.672845084463354, 85.42860344085487);
  final double _zoom = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _target,
          zoom: _zoom,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: Set<Marker>.from([
          Marker(
            markerId: MarkerId('location'),
            position: _target,
            infoWindow: InfoWindow(
              title: 'Location',
              snippet: 'Lat: 27.672968, Lng: 85.429291',
            ),
          ),
        ]),
      ),
    );
  }
}
