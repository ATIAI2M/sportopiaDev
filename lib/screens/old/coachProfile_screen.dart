// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/widgets/pack_item.dart';

// class CoachProfileSceen extends StatefulWidget {
//   const CoachProfileSceen({super.key});

//   @override
//   State<CoachProfileSceen> createState() => _CoachProfileSceenState();
// }

// class _CoachProfileSceenState extends State<CoachProfileSceen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//             child: Padding(
//           padding: const EdgeInsets.fromLTRB(28, 62, 28, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         width: 1,
//                         color: AppConstants.black,
//                       ),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back_ios_new),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       iconSize: 24,
//                       color: AppConstants.black,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 61,
//               ),
//               Container(
//                 width: double.infinity,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(children: [
//                       ClipOval(
//                         child: Image.asset('assets/images/coach.png',
//                             width: 72, height: 72, fit: BoxFit.cover),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Column(
//                         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.35,
//                                 child: AutoSizeText(
//                                   'COACH AFEF',
//                                   maxLines: 1,
//                                   style: GoogleFonts.teko(
//                                     textStyle: const TextStyle(
//                                       fontSize: 32,
//                                       fontWeight: FontWeight.w600,
//                                       color: AppConstants.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 Icons.verified,
//                                 color: Color(0xFF3897F0),
//                                 size: 25,
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.35,
//                             child: AutoSizeText(
//                               'Afef ben Mahmoud',
//                               maxLines: 1,
//                               style: GoogleFonts.roboto(
//                                   textStyle: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                   color: Color(0xFF9DB2CE)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ]),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.15,
//                       child: AutoSizeText(
//                         '4.8',
//                         maxLines: 1,
//                         style: GoogleFonts.teko(
//                           textStyle: const TextStyle(
//                             fontSize: 48,
//                             fontWeight: FontWeight.w600,
//                             color: AppConstants.critical,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 58,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'ABOUT',
//                   style: GoogleFonts.teko(
//                     color: AppConstants.gray1,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                     height: 0.06,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 'Creating a vibrant connection between well-being and art coaches and enthusiasts through like-minded communities to cultivate a harmonious and inspiring environment.',
//                 style: GoogleFonts.roboto(
//                     textStyle:
//                         TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
//                     color: AppConstants.gray1),
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       Chip(
//                         backgroundColor: Colors.transparent,
//                         label: const Text(
//                           'Healthy life-style',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: AppConstants.gray2),
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           side: const BorderSide(
//                             width: 1,
//                             color: AppConstants.gray2,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Chip(
//                         backgroundColor: Colors.transparent,
//                         label: const Text(
//                           'Mental health',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: AppConstants.gray2),
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           side: const BorderSide(
//                             width: 1,
//                             color: AppConstants.gray2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Chip(
//                         backgroundColor: Colors.transparent,
//                         label: const Text(
//                           'body-building',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: AppConstants.gray2),
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           side: const BorderSide(
//                             width: 1,
//                             color: AppConstants.gray2,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 48,
//               ),
//               Text(
//                 'CERTIFICATIONS',
//                 style: GoogleFonts.teko(
//                   color: AppConstants.gray1,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   height: 0.06,
//                 ),
//               ),
//               SizedBox(
//                 height: 48,
//               ),
//               Text(
//                 'CONNECT WITH AFEF',
//                 style: GoogleFonts.teko(
//                   color: AppConstants.gray1,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   height: 0.06,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Wrap(
//                 children: [
//                   Text(
//                     'INSTAGRAM',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.critical,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppConstants.critical,
//                       decorationThickness: 2,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'TIKTOK',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.critical,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppConstants.critical,
//                       decorationThickness: 2,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'WHATSAPP',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.critical,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppConstants.critical,
//                       decorationThickness: 2,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   Text(
//                     'FACEBOOK',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.critical,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.underline,
//                       decorationColor: AppConstants.critical,
//                       decorationThickness: 2,
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 48,
//               ),
//               Text(
//                 'AVAILABLE PACKS  ',
//                 style: GoogleFonts.teko(
//                   color: AppConstants.gray1,
//                   fontSize: 24,
//                   fontWeight: FontWeight.w600,
//                   height: 0.06,
//                 ),
//               ),
//               SizedBox(
//                 height: 32,
//               ),
//               Container(
//                 height: 120,
//                 child: ListView(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     PackItem(),
//                     SizedBox(
//                       width: 25,
//                     ),
//                     PackItem(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
