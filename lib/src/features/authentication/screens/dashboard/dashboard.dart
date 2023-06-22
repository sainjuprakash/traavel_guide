import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/common_widgets/cards/category_card.dart';
import 'package:login_setup/src/common_widgets/cards/recommended_card.dart';
import 'package:login_setup/src/common_widgets/animation/under_construction/under_construction.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/features/authentication/models/place_modal.dart';
import 'package:login_setup/src/features/authentication/screens/detail_screen/detail_screen.dart';
import 'package:login_setup/src/features/authentication/screens/map_screen/map_screen.dart';
import 'package:login_setup/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

import '../../../../common_widgets/cards/recommened/recommended_for_event.dart';
import '../dummy_dash/dash.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //const Dashboard({Key? key}) : super(key: key);
  static List<PlaceInfo> places = [];

  static List<PlaceInfo> allEvents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settemples();
    setAllEvents();
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
                      builder: (context) => Dash(),
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
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                  color: isDark ? tPrimaryClr : tDarkClr),
                              decoration: InputDecoration(
                                  hintText: "Search your destination",
                                  prefixIcon: Icon(Icons.search),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          ),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: tPrimaryClr,
                            child: Icon(
                              Icons.sort_by_alpha_sharp,
                              color: tWhiteClr,
                            ),
                          )
                        ],
                      ),
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
                Container(
                    height: 305,
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
                                                placeInfo: places[index])));
                                  },
                                )
                              ],
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
