// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/models/client.dart';
// import 'package:testapp/screens/home/settings_screen.dart';

// class MyprogressScreen extends StatefulWidget {
//   final Client client;
//   const MyprogressScreen({super.key, required this.client});

//   @override
//   State<MyprogressScreen> createState() => _MyprogressScreenState();
// }

// class _MyprogressScreenState extends State<MyprogressScreen> {
//   List<Color> changecolor = List.generate(4, (index) => AppConstants.gray1);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Container(
//           padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
//           height: 150,
//           width: double.infinity,
//           child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(MaterialPageRoute<void>(
//                       builder: (BuildContext context) => const Settingscreen(),
//                     ));
//                   },
//                   child: ClipOval(
//                     child: Image.asset(widget.client.imgUrl,
//                         width: 60, height: 60, fit: BoxFit.cover),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Welcome, ' + widget.client.fullName,
//                       style: GoogleFonts.teko(
//                         textStyle: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                           color: AppConstants.black,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       widget.client.status,
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                               fontSize: 12, fontWeight: FontWeight.w400),
//                           color: AppConstants.gray1),
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     alignment: Alignment.topRight,
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: AppConstants.line,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(
//                         Icons.notifications,
//                         size: 24,
//                         color: Color(0xFF848484),
//                       ),
//                     ),
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
// }
// //void chColor(int ind) {
//     //changecolor.setAll(0, List.generate(changecolor.length, (index) => const Color.fromARGB(255, 208, 56, 56)));
//     //changecolor[ind] = AppConstants.critical;
 
//     /* setState(() {
//       changecolor = changecolor == AppConstants.gray1
//           ? AppConstants.critical
//           : AppConstants.gray1;
//     });
//     for (int i = 0; i < changecolor.length; i++) {
//       if (i == ind) {
//         changecolor[i] = AppConstants.critical;
//       } else {
//         changecolor[i] = AppConstants.gray1;
//       }
//     }*/
  

//   /* bottomNavigationBar: Container(
//         height: 60,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: Offset(0, 3),
//               ),
//             ],
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(24),
//               topRight: Radius.circular(24),
//             ),
//             color: AppConstants.white),
//         child: Row(
//           children: [
//             IconButton(
//                 onPressed: () {
//                   chColor(0);
//                 },
//                 icon: Icon(Icons.home),
//                 color: changecolor[0]),
//             SizedBox(
//               width: 70,
//             ),
//             IconButton(
//                 onPressed: () {
//                   chColor(1);
//                 },
//                 icon: Icon(Icons.checklist),
//                 color: changecolor[1]),
//             SizedBox(
//               width: 70,
//             ),
//             IconButton(
//                 onPressed: () {
//                   chColor(2);
//                 },
//                 icon: Icon(Icons.explore),
//                 color: changecolor[2]),
//             SizedBox(
//               width: 70,
//             ),
//             IconButton(
//                 onPressed: () {
//                   chColor(3);
//                 },
//                 icon: Icon(Icons.calendar_month),
//                 color: changecolor[3]),
//           ],
//         ),
//       ),*/