import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/constants/image_strings.dart';
import 'package:login_setup/src/constants/sizes.dart';
import 'package:login_setup/src/constants/text_strings.dart';
import 'package:login_setup/src/features/authentication/controllers/profile_controller.dart';
import 'package:login_setup/src/features/authentication/models/user_model.dart';
import 'package:login_setup/src/features/authentication/screens/Scanner/scanner.dart';
import 'package:login_setup/src/features/authentication/screens/check-in/about_us.dart';
import 'package:login_setup/src/features/authentication/screens/check-in/user_checkin.dart';
import 'package:login_setup/src/features/authentication/screens/dashboard/dashboard.dart';
import 'package:login_setup/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:login_setup/src/features/authentication/screens/profile/widget/profile_menu_widget.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isDark = false;
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(Dashboard());
          },
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          tProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  // User data is available
                  UserModel user = snapshot.data as UserModel;

                  final email = TextEditingController(text: user.email);
                  final fullname = TextEditingController(text: user.fullname);

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image(image: AssetImage(tProfileImage)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: tPrimaryClr,
                              ),
                              child: Icon(
                                LineAwesomeIcons.alternate_pencil,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        fullname.text,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        email.text,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () => Get.to(() => UpdateProfileScreen()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryClr,
                            side: BorderSide.none,
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            tEditProfile,
                            style: TextStyle(color: tDarkClr),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Divider(),
                      SizedBox(height: 10),
                      ProfileMenuWidget(
                        title: 'Settings',
                        icon: LineAwesomeIcons.cog,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        title: 'Scan me',
                        icon: LineAwesomeIcons.wallet,
                        onPress: () => Get.to(()=> Scanner()),
                      ),
                      ProfileMenuWidget(
                        title: 'User\'s Check-in ',
                        icon: LineAwesomeIcons.user_check,
                        onPress: ()=> Get.to(()=>CheckIn()),
                      ),
                      Divider(color: Colors.grey),
                      SizedBox(height: 10),

                      ProfileMenuWidget(
                        title: 'About Us',
                        icon: LineAwesomeIcons.info,
                        onPress: () {
                          Get.to(()=>About());
                        },
                      ),
                      ProfileMenuWidget(
                        title: 'Logout',
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          AuthenticationRepository.instance.logout();
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  // Error occurred
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
            },
          ),
        ),
      ),
    );
  }
}
