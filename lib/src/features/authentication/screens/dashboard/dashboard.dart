import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/common_widgets/cards/category_card.dart';
import 'package:login_setup/src/common_widgets/cards/recommended_card.dart';
import 'package:login_setup/src/common_widgets/animation/under_construction/under_construction.dart';
import 'package:login_setup/src/common_widgets/cards/recommened/recommended_for_event.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/features/authentication/models/place_modal.dart';
import 'package:login_setup/src/features/authentication/screens/detail_screen/detail_screen.dart';
import 'package:login_setup/src/features/authentication/screens/map_screen/map_screen.dart';
import 'package:login_setup/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import '../ring_screen/ring_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
// final PlaceInfo placeInfo;
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static List<PlaceInfo> places = [];
  List<PlaceInfo> recommendations = [];
  List<PlaceInfo> data = [];

  //late final PlaceInfo placeInfo;
  // late String title;

  static List<PlaceInfo> allEvents = [];
  late String currentuser;
  String searchText = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settemples();
    setAllEvents();
    currentuser = FirebaseAuth.instance.currentUser!.uid;
    fetchRecommendations();
    //title = widget.placeInfo.title;
  }

  void fetchRecommendations() async {
    // if (title == 'temple') {
    var url = 'http://192.168.1.64:5000/predict';
    var body = jsonEncode({'user_id': currentuser});

    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print('Recommendations data: $data');

      List<int> recommendationIds = List<int>.from(data);
      print('Number of recommendations: ${recommendationIds.length}');

      List<PlaceInfo> recommendedTemples = [];

      // Initialize the PlacesService class
      PlacesService placesService = PlacesService();

      // Fetch all temples from the API
      List<PlaceInfo> temples = await placesService.getTemples();

      for (int id in recommendationIds) {
        PlaceInfo temple =
            temples.firstWhere((temples) => temples.id == (id + 1));
        if (temple != null) {
          recommendedTemples.add(temple);
        }
      }

      setState(() {
        recommendations = recommendedTemples;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    //  // }
    //    else if (title == 'pond') {
    //     var url = 'http://192.168.1.64:5000/predict';
    //     var body = jsonEncode({'user_id': currentuser});

    //     var response = await http.post(
    //       Uri.parse(url),
    //       headers: {'Content-Type': 'application/json'},
    //       body: body,
    //     );

    //     if (response.statusCode == 200) {
    //       var data = jsonDecode(response.body);
    //       print('Recommendations data: $data');

    //       List<int> recommendationIds = List<int>.from(data);
    //       print('Number of recommendations: ${recommendationIds.length}');

    //       List<PlaceInfo> recommendedPonds = [];

    //       // Initialize the PlacesService class
    //       PlacesService placesService = PlacesService();

    //       // Fetch all temples from the API
    //       List<PlaceInfo> temples = await placesService.getPonds();

    //       for (int id in recommendationIds) {
    //         PlaceInfo pond = temples.firstWhere((ponds) => ponds.id == (id + 1));
    //         if (pond != null) {
    //           recommendedPonds.add(pond);
    //         }
    //       }

    //       setState(() {
    //         recommendations = recommendedPonds;
    //       });
    //     } else {
    //       print('Request failed with status: ${response.statusCode}.');
    //     }
    //   }
  }

  void settemples() async {
    List<PlaceInfo> temples = await PlacesService().getTemples();
    setState(() {
      places = [];
      places = temples;
    });
  }

  void setponds() async {
    List<PlaceInfo> ponds = await PlacesService().getPonds();
    setState(() {
      places = [];
      places = ponds;
    });
  }

  void setchowks() async {
    List<PlaceInfo> chowks = await PlacesService().getchowks();
    setState(() {
      places = [];
      places = chowks;
    });
  }

  void setmeseums() async {
    List<PlaceInfo> meseums = await PlacesService().getmeseums();
    setState(() {
      places = [];
      places = meseums;
    });
  }

  void setstatues() async {
    List<PlaceInfo> statues = await PlacesService().getstatues();
    setState(() {
      places = [];
      places = statues;
    });
  }

  void setAllEvents() async {
    List<PlaceInfo> events = await PlacesService().getAllEvents();
    setState(() {
      allEvents = [];
      allEvents = events;
    });
  }

  void setUpcomingEvents() async {
    List<PlaceInfo> upcomingEvents = await PlacesService().getUpcomingEvents();
    setState(() {
      allEvents = [];
      allEvents = upcomingEvents;
    });
  }

// Defining a function to search in the MySQL database
  Future<List<PlaceInfo>> searchInDatabase(String query) async {
    final apiUrl = 'https://192.168.1.64/api/search.php';

    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    // Create an IOClient with the custom HttpClient
    final ioClient = IOClient(httpClient);

    // Send the HTTP GET request using the IOClient
    final response = await ioClient.get(Uri.parse('$apiUrl?query=$query'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final responseData = jsonDecode(response.body);

      // Process the response data and create a list of PlaceInfo objects
      List<PlaceInfo> searchResults = responseData.map<PlaceInfo>((data) {
        // Assuming you have a constructor in PlaceInfo that accepts the necessary fields
        return PlaceInfo(
          id: data['TempleID'],
          name: data['Name'], address: data['Address'], city: data['City'],
          desc: data['Description'], imageUrl: data['ImageURL'],
          title: data['title'],
          // Add other fields as necessary
        );
      }).toList();

      // Return the search results
      return searchResults;
    } else {
      throw Exception('Failed to search in the database');
    }
  }

// Implemention of the search functionality
  void searchDestination(String query) {
    print('hello');
    print(query);

    // Call the function to search in the MySQL database
    searchInDatabase(query).then((List<PlaceInfo> results) {
      // Process the search results
      setState(() {
        data = results;
      });
    }).catchError((error) {
      // Handle any errors that occur during the search process
      print('Search error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    //print(places[0].name);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Get.to(ProfileScreen()),
                icon: Icon(Icons.person_outline, size: 30),
              ),
              IconButton(
                onPressed: () => Get.to(UnderConstruction()),
                icon: Icon(Icons.favorite_outline, size: 30),
              ),
              IconButton(
                onPressed: () => Get.to(Dashboard()),
                icon: Icon(Icons.home, size: 30, color: Colors.redAccent),
              ),
              IconButton(
                onPressed: () => Get.to(MapView()),
                icon: Icon(Icons.location_on_outlined, size: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RingsPage(),
                    ),
                  );
                },
                icon: Icon(Icons.list, size: 30),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*******APP_BAR********/
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        AuthenticationRepository.instance.logout();
                        GoogleSignIn().signOut();
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: AssetImage("assets/images/user.png"),
                        backgroundColor: isDark ? tSecondaryClr : tAccentClr,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Hello",
                            style: TextStyle(
                                color: isDark ? tWhiteClr : tDarkClr,
                                fontSize: 18),
                            children: [
                          TextSpan(
                              text: ", Alexa",
                              style: TextStyle(
                                  color: isDark ? tWhiteClr : tDarkClr,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))
                        ]))
                  ],
                ),

                /**********SEARCH_SECTION**********/
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Explore new destination",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  borderRadius: BorderRadius.circular(100),
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? tSecondaryClr : tWhiteClr,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    color: isDark ? tPrimaryClr : tDarkClr,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Search your destination",
                                    prefixIcon: Icon(Icons.search),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      searchText = value;
                                    });
                                    searchDestination(value);
                                  },
                                ),
                              ),
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: tPrimaryClr,
                                child: Icon(
                                  Icons.sort_by_alpha_sharp,
                                  color: tWhiteClr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                if (searchText.isNotEmpty && data.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.shade100,
                    child: Column(
                      children: [
                        Text(
                          'Search Results',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: SingleChildScrollView(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey,
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Icon(Icons.location_on, size: 20),
                                  title: Text(
                                    data[index].name,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(
                                    data[index].address,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          placeInfo: data[index],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              //itemCount: 60, // Adjust this value as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 8),
                if (searchText.isNotEmpty && data.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.shade200,
                    child: Text(
                      'No results found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                /***************CATEGORY***********/
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text("Category", style: txtTheme.headlineMedium),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          CategoryCard(
                            press: () {
                              settemples();
                            },
                            image: "assets/images/temple.jpg",
                            title: "Temples",
                          ),
                          CategoryCard(
                            press: () {
                              setponds();
                            },
                            image: "assets/images/pond.jpg",
                            title: "Ponds",
                          ),
                          CategoryCard(
                            press: () {
                              setchowks();
                            },
                            image: "assets/images/chwo.webp",
                            title: "chowks",
                          ),
                          CategoryCard(
                            press: () {
                              setmeseums();
                            },
                            image: "assets/images/meu.webp",
                            title: "Mesuems",
                          ),
                          CategoryCard(
                            press: () {
                              setstatues();
                            },
                            image: "assets/images/stat.jpg",
                            title: "Statues",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 290,
                    child: ListView.builder(
                        itemCount: places.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 15),
                            child: Row(
                              children: [
                                RecommendedCard(
                                  placeInfo: places[index],
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  placeInfo: places[index],
                                                )));
                                  },
                                )
                              ],
                            ),
                          );
                        })),

/****************Events****************/
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Events",
                      style: txtTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          CategoryCard(
                            press: () {
                              setAllEvents();
                            },
                            image: "assets/images/temple.jpg",
                            title: "All Events",
                          ),
                          CategoryCard(
                            press: () {
                              setUpcomingEvents();
                            },
                            image: "assets/images/pond.jpg",
                            title: "Upcoming Events",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 300,
                    child: ListView.builder(
                        itemCount: places.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 5, right: 15),
                            child: Row(
                              children: [
                                RecommendedForEvent(
                                  placeInfo: allEvents[index],
                                  press: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                placeInfo: allEvents[index])));
                                  },
                                )
                              ],
                            ),
                          );
                        })),

                /********RECOMMENDED****************/
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Recommendation",
                      style: txtTheme.headlineMedium,
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: recommendations.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5, right: 15),
                        child: Expanded(
                          child: Row(
                            children: [
                              RecommendedCard(
                                placeInfo: recommendations[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        placeInfo: recommendations[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
