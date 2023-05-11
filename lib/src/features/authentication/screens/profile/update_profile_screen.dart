// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:login_setup/src/features/authentication/controllers/profile_controller.dart';
// import 'package:login_setup/src/features/authentication/models/user_model.dart';

// import '../../../../constants/colors.dart';
// import '../../../../constants/image_strings.dart';
// import '../../../../constants/sizes.dart';
// import '../../../../constants/text_strings.dart';

// class UpdateProfileScreen extends StatelessWidget {
//   const UpdateProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ProfileController());
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () => Get.back(),
//               icon: const Icon(LineAwesomeIcons.angle_left)),
//           title: Text(
//             tEditProfile,
//             style: Theme.of(context).textTheme.headline4,
//           ),
//         ),
//         body: SingleChildScrollView(
//             child: Container(
//           padding: EdgeInsets.all(tDefaultSize),
//           child: FutureBuilder(
//             future: controller.getUserData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 if (snapshot.hasData) {
//                   UserModel userData = snapshot.data as UserModel;
//                   return Column(children: [
//                     Stack(
//                       children: [
//                         SizedBox(
//                           width: 120,
//                           height: 120,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               child: Image(image: AssetImage(tProfileImage))),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             width: 35,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: tPrimaryClr,
//                             ),
//                             child: Icon(
//                               LineAwesomeIcons.camera,
//                               size: 20,
//                               color: Colors.black,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Form(
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: controller.fullname,
//                             initialValue: userData.fullname,
//                             decoration: InputDecoration(
//                                 label: Text(tFullName),
//                                 prefixIcon: Icon(LineAwesomeIcons.user)),
//                           ),
//                           SizedBox(
//                             height: tFormHeight - 20,
//                           ),
//                           TextFormField(
//                             controller: controller.email,
//                             initialValue: userData.email,
//                             decoration: InputDecoration(
//                                 label: Text(tEmail),
//                                 prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
//                           ),
//                           SizedBox(
//                             height: tFormHeight - 20,
//                           ),
//                           TextFormField(
//                             controller: controller.phoneNo,
//                             initialValue: userData.phoneNo,
//                             decoration: InputDecoration(
//                                 label: Text(tPhoneNo),
//                                 prefixIcon: Icon(LineAwesomeIcons.phone)),
//                           ),
//                           SizedBox(
//                             height: tFormHeight - 20,
//                           ),
//                           TextFormField(
//                             controller: controller.password,
//                             initialValue: userData.password,
//                             decoration: InputDecoration(
//                                 label: Text(tPassword),
//                                 prefixIcon: Icon(LineAwesomeIcons.fingerprint)),
//                           ),
//                           SizedBox(
//                             height: tFormHeight,
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () =>
//                                   Get.to(() => UpdateProfileScreen()),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: tPrimaryClr,
//                                 side: BorderSide.none,
//                                 shape: StadiumBorder(),
//                               ),
//                               child: Text(
//                                 tEditProfile,
//                                 style: TextStyle(color: tDarkClr),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: tFormHeight,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text.rich(TextSpan(
//                                   text: tJoined,
//                                   style: TextStyle(fontSize: 12),
//                                   children: [
//                                     TextSpan(
//                                         text: tJoinedAt,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12))
//                                   ])),
//                               ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         Colors.redAccent.withOpacity(0.1),
//                                     elevation: 0,
//                                     foregroundColor: Colors.red,
//                                     shape: StadiumBorder(),
//                                     side: BorderSide.none,
//                                   ),
//                                   child: Text(tDelete))
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ]);
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 } else {
//                   return Center(
//                     child: Text("Something went wrong."),
//                   );
//                 }
//               } else {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         )));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/constants/image_strings.dart';
import 'package:login_setup/src/constants/sizes.dart';
import 'package:login_setup/src/constants/text_strings.dart';
import 'package:login_setup/src/features/authentication/controllers/profile_controller.dart';
import 'package:login_setup/src/features/authentication/models/user_model.dart';
import 'package:login_setup/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:login_setup/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:login_setup/src/features/authentication/screens/profile/widget/profile_menu_widget.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(ProfileScreen());
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text(
          tEditProfile,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;
                    final id = TextEditingController(text: user.id);
                    final email = TextEditingController(text: user.email);
                    final password = TextEditingController(text: user.password);
                    final fullname = TextEditingController(text: user.fullname);
                    final phoneNo = TextEditingController(text: user.phoneNo);

                    return Column(children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(image: AssetImage(tProfileImage))),
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
                                LineAwesomeIcons.camera,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            controller: fullname,
                            decoration: InputDecoration(
                                label: Text(tFullName),
                                prefixIcon: Icon(LineAwesomeIcons.user)),
                          ),
                          SizedBox(
                            height: tFormHeight - 20,
                          ),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                label: Text(tEmail),
                                prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                          ),
                          SizedBox(
                            height: tFormHeight - 20,
                          ),
                          TextFormField(
                            controller: phoneNo,
                            decoration: InputDecoration(
                                label: Text(tPhoneNo),
                                prefixIcon: Icon(LineAwesomeIcons.phone)),
                          ),
                          SizedBox(
                            height: tFormHeight - 20,
                          ),
                          TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                                label: Text(tPassword),
                                prefixIcon: Icon(LineAwesomeIcons.fingerprint)),
                          ),
                          SizedBox(
                            height: tFormHeight,
                          ),

                          //Form Submit Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final user = UserModel(
                                    id: id.text,
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    fullname: fullname.text.trim(),
                                    phoneNo: phoneNo.text.trim());

                                await controller.updateRecord(user);
                              },
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
                          SizedBox(
                            height: tFormHeight,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(TextSpan(
                                    text: tJoined,
                                    style: TextStyle(fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: tJoinedAt,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12))
                                    ])),
                              ])
                        ],
                      ))
                    ]);
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return Center(child: Text("Something Went Wrong."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
