// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/screens/old/filterCoaches_screen.dart';

// class FindCoachesEmpty extends StatefulWidget {
//   const FindCoachesEmpty({super.key});

//   @override
//   State<FindCoachesEmpty> createState() => _FindCoachesEmptyState();
// }

// class _FindCoachesEmptyState extends State<FindCoachesEmpty> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(28, 51.5, 28, 0),
//           child: Column(
//             children: [
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // Navigator.of(context).push(MaterialPageRoute<void>(
//                         //   builder: (BuildContext context) => const Settingscreen(),
//                         // ));
//                       },
//                       child: ClipOval(
//                         child: Image.asset('assets/images/profile.jpg',
//                             width: 60, height: 60, fit: BoxFit.cover),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome, Omar',
//                           style: GoogleFonts.teko(
//                             textStyle: const TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.w600,
//                               color: AppConstants.black,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           'Beginner',
//                           style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w400),
//                               color: AppConstants.gray1),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: double.infinity,
//                         alignment: Alignment.topRight,
//                         child: Container(
//                           width: 45,
//                           height: 45,
//                           decoration: BoxDecoration(
//                             color: AppConstants.line,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Icon(
//                             Icons.notifications,
//                             size: 24,
//                             color: Color(0xFF848484),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                       child: TextField(
//                     keyboardType: TextInputType.text,
//                     autofocus: false,
//                     style: TextStyle(
//                       color: AppConstants.gray1,
//                     ),
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide:
//                             BorderSide(width: 1, color: Color(0xFFEDEDED)),
//                         borderRadius: BorderRadius.circular(45.0),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: AppConstants.gray1,
//                         ),
//                         borderRadius: BorderRadius.circular(45.0),
//                       ),
//                       labelStyle: TextStyle(color: Color(0xFFFB3B2B2)),
//                       filled: true,
//                       fillColor: Color(0xFFFBFBFB),
//                       contentPadding:
//                           EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(45.0),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.search,
//                         color: AppConstants.gray1,
//                       ),
//                       hintText: 'Search here ...',
//                       hintStyle: TextStyle(
//                         color: AppConstants.gray1,
//                       ),
//                     ),
//                   )),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         color: AppConstants.black,
//                         borderRadius: BorderRadius.circular(55)),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.tune,
//                         color: AppConstants.line,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacement(MaterialPageRoute<void>(
//                           builder: (BuildContext context) =>
//                               const FilterCoaches(),
//                         ));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(child: Container()),
//               Image.asset('assets/images/Vector.png', width: 120, height: 80),
//               SizedBox(
//                 height: 25,
//               ),
//               Text(
//                 'OH HOW EMPTY ',
//                 style: GoogleFonts.teko(
//                     textStyle: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         color: AppConstants.gray2)),
//               ),
//               Text(
//                 'We couldn’t find suitable results, \n please update your filter ',
//                 textAlign: TextAlign.center,
//                 style: (TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: AppConstants.gray2)),
//               ),
//               Expanded(child: Container())
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
