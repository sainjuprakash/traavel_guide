import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_setup/src/features/authentication/controllers/profile_controller.dart';

import 'package:login_setup/src/features/authentication/screens/map_screen/map_service.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_strings.dart';
import '../../../provider/searchplaces.dart';
import '../../controllers/helper_copntroller.dart';
import '../../models/auto_complete_results.dart';

import 'dart:ui' as ui;

import '../../models/user_model.dart';

class Location {
  final double latitude;
  final double longitude;

  Location(this.latitude, this.longitude);
}

class MapView extends ConsumerStatefulWidget {
  const MapView({
    super.key,
  });

  @override
  ConsumerState<MapView> createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  final controller = Get.put(ProfileController());
  Completer<GoogleMapController> _controller = Completer();
// initial camera position
  static final CameraPosition _BktDS = CameraPosition(
    target: LatLng(27.672225955163956, 85.42804580706749),
    zoom: 15,
  );

//toogle for running method on change
  bool searchToggle = false;
  bool radiusSlider = false;
  bool nearplacePressed = false;
  bool navaigationtoggle = false;
  bool cardTapped = false;
  bool getDirection = false;
  bool pressedNear = false;

  //throttel async
  Timer? _debounce;
  int markerIdCounter = 1;
  int polylineIdCounter = 1;

  var radiusValue = 3000.0;

  var tappedPoint;

  List allFavoritePlaces = [];

  String tokenKey = '';

  //marker set
  Set<Marker> _markers = Set<Marker>();

  Set<Marker> _markersDupe = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();

  Set<Circle> _circles = Set<Circle>();

  //textbox controller
  TextEditingController SearchController = TextEditingController();
  TextEditingController OriginController = TextEditingController();
  TextEditingController DestinationController = TextEditingController();
  List<Location> locations = [];
  LatLng? currentLocation;
  Marker? currentLocationMarker;
  GoogleMapController? myMapController;

  Future<void> findCurrentLocation({bool focusCamera = true}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Helper.errorSnackBar(title: tOhSnap, message: 'Location is disabled');
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      Helper.errorSnackBar(
          title: tOhSnap,
          message:
              'Location permissions are permanently denied, we cannot request permissions.');

      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        Helper.errorSnackBar(
            title: tOhSnap,
            message:
                'Location permissions are denied (actual value: $permission).');

        return;
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Print the latitude and longitude
    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
    if (focusCamera && currentLocation != null) {
      myMapController?.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation!, 14),
      );
    }
    if (mounted) {
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        currentLocationMarker = Marker(
          markerId: MarkerId('currentLocation'),
          position: currentLocation!,
          icon: BitmapDescriptor.defaultMarker,
        );
      });
    }

    locations = [
      Location(27.672845084463354, 85.42860344085487),
      Location(27.678749189854676, 85.43245935523576),
      Location(27.665986314281638, 85.41680468661702),
    ];
  }

  Future<void> gotosearchedPlaces(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));
    _setmarker(LatLng(lat, lng));
  }

  Future<void> gotoPlace(
      double startlat,
      double startlng,
      double endlat,
      double endlng,
      Map<String, dynamic> boundsNe,
      Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(boundsNe['lat'], boundsSw['lng']),
          northeast: LatLng(boundsNe['lat'], boundsSw['lng']),
        ),
        25));

    _setmarker(LatLng(startlat, startlng));
    _setmarker(LatLng(endlat, endlng));
  }

  void _setmarker(point) {
    var counter = markerIdCounter++;
    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    setState(() {
      _markers.add(marker);
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    String polylineID = 'Polyline_$polylineIdCounter';
    polylineIdCounter++;
    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineID),
        width: 2,
        color: Colors.blue,
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      ),
    );
  }

  void _setCircle(LatLng point) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 13)));
    setState(() {
      _circles.add(Circle(
          circleId: CircleId('bajaj'),
          center: point,
          fillColor: Colors.blue.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: Colors.blue,
          strokeWidth: 1));
      getDirection = false;
      searchToggle = false;
      radiusSlider = true;
    });
  }

  _setNearMarker(LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    if (types.contains('restaurants'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    else if (types.contains('food'))
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    else if (types.contains('school'))
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    else if (types.contains('bar'))
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    else if (types.contains('lodging'))
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    else if (types.contains('store'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    else if (types.contains('locality'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    else
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
  }

  _setMarker(LatLng point, String label, List types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    if (types.contains('restaurants'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    else if (types.contains('food'))
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    else if (types.contains('school'))
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    else if (types.contains('bar'))
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    else if (types.contains('lodging'))
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    else if (types.contains('store'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    else if (types.contains('locality'))
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    else
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
  }

  List<Marker> templeMarkers = [
    Marker(
      markerId: MarkerId('temple1'),
      position: LatLng(27.672845084463354, 85.42860344085487),
      // Add other properties like icon, info window, etc. as needed
    ),
    Marker(
      markerId: MarkerId('temple2'),
      position: LatLng(27.678749189854676, 85.43245935523576),
      // Add other properties like icon, info window, etc. as needed
    ),
    Marker(
      markerId: MarkerId('temple3'),
      position: LatLng(27.665986314281638, 85.41680468661702),
      // Add other properties like icon, info window, etc. as needed
    ),
  ];
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    findCurrentLocation(focusCamera: false).then((_) {
      if (currentLocation != null) {
        myMapController?.animateCamera(
          CameraUpdate.newLatLngZoom(currentLocation!, 14),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    final allsearchResults = ref.watch(palceResultsProvider);
    final searchFlag = ref.watch(searchToggleProvider);
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _BktDS,
              // markers: _markers,
              markers: Set<Marker>.of([
                if (currentLocation != null)
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: currentLocation!,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                ..._buildLocationMarkers(), // Add the markers from local database
              ]),
              polylines: _polylines,
              circles: _circles,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                myMapController = controller;
              },
              onTap: (point) {
                tappedPoint = point;
                _setCircle(point);
              },
            ),
          ),
          searchToggle
              ? Positioned(
                  top: 170,
                  left: 20,
                  right: 20,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 59, 155, 224),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: TextFormField(
                          controller: SearchController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              hintText: 'Search',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchToggle = false;
                                    SearchController.text = '';
                                    _markers = {};
                                    if (searchFlag.searchToggle)
                                      searchFlag.toggleSearch();
                                  });
                                },
                                icon: Icon(Icons.close),
                              )),
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false)
                              _debounce?.cancel();
                            _debounce =
                                Timer(Duration(milliseconds: 700), () async {
                              if (value.length > 2) {
                                if (!searchFlag.searchToggle) {
                                  searchFlag.toggleSearch();
                                  _markers = {};
                                }

                                List<AutoCompleteResult> searchResults =
                                    await MapServices().searchPlaces(value);

                                allsearchResults.setPlaces(searchResults);
                              } else {
                                List<AutoCompleteResult> emptyList = [];
                                allsearchResults.setPlaces(emptyList);
                              }
                            });
                          },
                        ),
                      )),
                )
              : Container(),
          searchFlag.searchToggle
              ? allsearchResults.allreturnedplaces != 0
                  ? Positioned(
                      top: 90,
                      left: 15,
                      child: Container(
                          height: 200,
                          width: screenwidth - 30.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.7)),
                          child: ListView(
                            children: [
                              ...allsearchResults.allreturnedplaces
                                  .map((e) => buildListItem(e, searchFlag))
                            ],
                          )))
                  : Positioned(
                      top: 100.0,
                      left: 15.0,
                      child: Container(
                        height: 200.0,
                        width: screenwidth - 30.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child: Center(
                          child: Column(children: [
                            Text('No results to show',
                                style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 5.0),
                            Container(
                              width: 125.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  searchFlag.toggleSearch();
                                },
                                child: Center(
                                  child: Text(
                                    'Close this',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ))
              : Container(),
          getDirection
              ? Positioned(
                  top: 170,
                  left: 20,
                  right: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 165, 226),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                                controller: OriginController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 15.0),
                                    hintText: 'Starting',
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          getDirection = false;
                                        });
                                      },
                                      icon: Icon(Icons.close),
                                    )))),
                        SizedBox(height: 3.0),
                        Container(
                            height: 50,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 78, 166, 230),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: TextFormField(
                                controller: DestinationController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 15.0),
                                    hintText: 'Destination',
                                    border: InputBorder.none,
                                    suffixIcon: Container(
                                      width: 100.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              var directions =
                                                  await MapServices()
                                                      .getDirection(
                                                          OriginController.text,
                                                          DestinationController
                                                              .text);
                                              _markers = {};
                                              _polylines = {};
                                              gotoPlace(
                                                  directions['start_location']
                                                      ['lat'],
                                                  directions['start_location']
                                                      ['lng'],
                                                  directions['end_location']
                                                      ['lat'],
                                                  directions['end_location']
                                                      ['lng'],
                                                  directions['bounds_ne'],
                                                  directions['bounds_sw']);
                                              _setPolyline(directions[
                                                  'polyline_decoded']);
                                            },
                                            icon: Icon(Icons.search),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                getDirection = false;
                                                OriginController.text = '';
                                                DestinationController.text = '';
                                                _markers = {};
                                                _polylines = {};
                                              });
                                            },
                                            icon: Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    )))),
                      ],
                    ),
                  ),
                )
              : Container(),
          radiusSlider
              ? Padding(
                  padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                  child: Container(
                    height: 50.0,
                    color: Colors.black.withOpacity(0.2),
                    child: Row(
                      children: [
                        Expanded(
                            child: Slider(
                                max: 7000.0,
                                min: 1000.0,
                                value: radiusValue,
                                onChanged: (newVal) {
                                  radiusValue = newVal;
                                  pressedNear = false;
                                  _setCircle(tappedPoint);
                                })),
                        !pressedNear
                            ? IconButton(
                                onPressed: () {
                                  if (_debounce?.isActive ?? false)
                                    _debounce?.cancel();
                                  _debounce =
                                      Timer(Duration(seconds: 2), () async {
                                    var placesResult = await MapServices()
                                        .getPlaceDetails(
                                            tappedPoint, radiusValue.toInt());

                                    List<dynamic> placesWithin =
                                        placesResult['results'] as List;

                                    allFavoritePlaces = placesWithin;

                                    tokenKey =
                                        placesResult['next_page_token'] ??
                                            'none';
                                    _markers = {};
                                    placesWithin.forEach((element) {
                                      _setNearMarker(
                                        LatLng(
                                            element['geometry']['location']
                                                ['lat'],
                                            element['geometry']['location']
                                                ['lng']),
                                        element['name'],
                                        element['types'],
                                        element['business_status'] ??
                                            'not available',
                                      );
                                    });
                                    _markersDupe = _markers;
                                    pressedNear = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.near_me,
                                  color: Colors.blue,
                                ))
                            : IconButton(
                                onPressed: () {
                                  if (_debounce?.isActive ?? false)
                                    _debounce?.cancel();
                                  _debounce =
                                      Timer(Duration(seconds: 2), () async {
                                    if (tokenKey != 'none') {
                                      var placesResult = await MapServices()
                                          .getMorePlaceDetails(tokenKey);

                                      List<dynamic> placesWithin =
                                          placesResult['results'] as List;

                                      allFavoritePlaces.addAll(placesWithin);

                                      tokenKey =
                                          placesResult['next_page_token'] ??
                                              'none';

                                      placesWithin.forEach((element) {
                                        _setNearMarker(
                                          LatLng(
                                              element['geometry']['location']
                                                  ['lat'],
                                              element['geometry']['location']
                                                  ['lng']),
                                          element['name'],
                                          element['types'],
                                          element['business_status'] ??
                                              'not available',
                                        );
                                      });
                                    } else {
                                      print('Thats all folks!!');
                                    }
                                  });
                                },
                                icon:
                                    Icon(Icons.more_time, color: Colors.blue)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                radiusSlider = false;
                                // pressedNear = false;
                                cardTapped = false;
                                radiusValue = 3000.0;
                                _circles = {};
                                _markers = {};
                                // allFavoritePlaces = [];
                              });
                            },
                            icon: Icon(Icons.close, color: Colors.red))
                      ],
                    ),
                  ),
                )
              : Container(),
          buildProfileTile(controller, isDark),
          buildCurrentLocationIcon(),
        ],
      ),
      floatingActionButton: FabCircularMenu(
        alignment: Alignment.bottomLeft,
        fabColor: Colors.blue.shade800,
        fabOpenColor: Color.fromARGB(255, 161, 25, 45),
        fabCloseColor: Color.fromARGB(255, 41, 201, 54),
        ringDiameter: 250.0,
        ringWidth: 65.0,
        ringColor: Colors.blue.shade800,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  searchToggle = false;
                  radiusSlider = false;
                  nearplacePressed = false;
                  navaigationtoggle = false;
                  cardTapped = false;
                  getDirection = true;
                });
              },
              icon: Icon(Icons.navigation)),
          IconButton(
              onPressed: () {
                _setMarker(LatLng(27.672225955163956, 85.42804580706749), 'aa',
                    ['restaurants'], 'kk');
              },
              icon: Icon(Icons.museum_sharp)),
          IconButton(
              onPressed: () {
                setState(() {
                  //   searchToggle = false;
                  //   radiusSlider = false;
                  //   nearplacePressed = false;
                  //   navaigationtoggle = false;
                  //   cardTapped = false;
                  //   getDirection = true;
                  //
                });
              },
              icon: Icon(Icons.temple_hindu)),
          IconButton(
              onPressed: () {
                setState(() {
                  searchToggle = true;
                  radiusSlider = false;
                  nearplacePressed = false;
                  navaigationtoggle = false;
                  cardTapped = false;
                  getDirection = false;
                });
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }

  Widget buildListItem(AutoCompleteResult placelist, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: GestureDetector(
          onTapDown: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () async {
            var place = await MapServices().getPlaces(placelist.placeId);
            gotosearchedPlaces(place['geometry']['location']['lat'],
                place['geometry']['location']['lng']);
            searchFlag.toggleSearch();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.blue, size: 25),
              SizedBox(width: 30),
              Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 45.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(placelist.description ?? ''),
                ),
              )
            ],
          )),
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

  Widget buildCurrentLocationIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 25),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: tPrimaryClr,
          child: IconButton(
            onPressed: () {
              findCurrentLocation(focusCamera: true);
            },
            icon: Icon(
              Icons.my_location,
              color: tWhiteClr,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  List<Marker> _buildLocationMarkers() {
    return locations.map((location) {
      return Marker(
        markerId: MarkerId("${location.latitude}-${location.longitude}"),
        position: LatLng(location.latitude, location.longitude),
        // Add other properties like icon, info window, etc. as needed
      );
    }).toList();
  }
}
