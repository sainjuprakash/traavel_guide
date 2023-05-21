// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
// import 'package:login_setup/src/constants/sizes.dart';
// import 'package:login_setup/src/constants/text_strings.dart';
// import 'package:login_setup/src/features/authentication/controllers/mail_verification_controller.dart';
// import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

// class MailVerification extends StatelessWidget {
//   const MailVerification({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(MailVerificationController());
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(
//               top: tDefaultSize * 5,
//               left: tDefaultSize,
//               right: tDefaultSize,
//               bottom: tDefaultSize * 2),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 LineAwesomeIcons.envelope_open,
//                 size: 100,
//               ),
//               SizedBox(
//                 height: tDefaultSize * 2,
//               ),
//               Text(
//                 tEmailVerificationTitle.tr,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               SizedBox(
//                 height: tDefaultSize,
//               ),
//               Text(
//                 tEmailVerificationSubtitle.tr,
//                 style: Theme.of(context).textTheme.bodyMedium,
//               ),
//               SizedBox(
//                 height: tDefaultSize * 2,
//               ),
//               SizedBox(
//                 width: 200,
//                 child: OutlinedButton(
//                   child: Text(tContinue.tr),
//                   onPressed: () =>
//                       controller.manuallyCheckEmailVerificationStatus(),
//                 ),
//               ),
//               SizedBox(
//                 height: tDefaultSize * 2,
//               ),
//               TextButton(
//                   onPressed: () => controller.sendVerificationEmail(),
//                   child: Text(tResendEmailLink.tr)),
//               TextButton(
//                   onPressed: () => AuthenticationRepository.instance.logout(),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(LineAwesomeIcons.alternate_long_arrow_left),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(tBackToLogin.tr.toLowerCase())
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
