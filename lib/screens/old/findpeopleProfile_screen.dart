// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/widgets/report_alert.dart';
// import 'package:testapp/widgets/review_alert.dart';

// import '../models/client.dart';

// class FindPeopleProfileScreen extends StatefulWidget {
//   final Client client;
//   const FindPeopleProfileScreen({super.key, required this.client});

//   @override
//   State<FindPeopleProfileScreen> createState() =>
//       _FindPeopleProfileScreenState();
// }

// class _FindPeopleProfileScreenState extends State<FindPeopleProfileScreen> {
//   String communication = '';
//   String professionnalisme = '';
//   String utile = '';
//   String amical = '';
//   String respectueux = '';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 child: Stack(
//                   children: [
//                     Image.asset(widget.client.imgUrl),
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
//                       child: Row(
//                         children: [
//                           Container(
//                             // margin: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 width: 1,
//                                 color: AppConstants.line,
//                               ),
//                             ),
//                             child: IconButton(
//                               icon: Icon(Icons.arrow_back_ios_new),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 /*
//                                 Navigator.of(context)
//                                     .pushReplacement(MaterialPageRoute<void>(
//                                   builder: (BuildContext context) =>
//                                       const StartScreen(),
//                                 ));*/
//                               },
//                               iconSize: 24,
//                               color: AppConstants.line,
//                             ),
//                           ),
//                           Expanded(child: Container()),
//                           Container(
//                             margin: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 width: 1,
//                                 color: AppConstants.line,
//                               ),
//                             ),
//                             child: IconButton(
//                               icon: Icon(
//                                 Icons.more_vert,
//                                 color: AppConstants.line,
//                               ),
//                               onPressed: () {
//                                 showModalBottomSheet(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.vertical(
//                                         top: Radius.circular(13.0)),
//                                   ),
//                                   backgroundColor:
//                                       Color.fromRGBO(24, 24, 24, 1),
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return Container(
//                                       decoration: const BoxDecoration(),
//                                       height: 220,
//                                       child: Padding(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             16, 12, 16, 0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           // mainAxisSize: MainAxisSize.min,

//                                           children: <Widget>[
//                                             Text("Explorer les options",
//                                                 style: GoogleFonts.roboto(
//                                                   textStyle: const TextStyle(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: AppConstants.gray1,
//                                                   ),
//                                                 )),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             Text(
//                                                 "Sélectionnez une action à poursuivre",
//                                                 style: GoogleFonts.roboto(
//                                                   textStyle: const TextStyle(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.w600,
//                                                     color: AppConstants.gray1,
//                                                   ),
//                                                 )),
//                                             Divider(
//                                               color: AppConstants.gray1,
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 showModalBottomSheet<void>(
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.vertical(
//                                                             top:
//                                                                 Radius.circular(
//                                                                     13.0)),
//                                                   ),
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) {
//                                                     return SizedBox(
//                                                       height: 400,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         children: <Widget>[
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           16.0),
//                                                               child: Text(
//                                                                   'Signaler ' +
//                                                                       widget
//                                                                           .client
//                                                                           .fullName
//                                                                           .toUpperCase(),
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .teko(
//                                                                     textStyle: const TextStyle(
//                                                                         fontSize:
//                                                                             24,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w600,
//                                                                         color: AppConstants
//                                                                             .gray1),
//                                                                   )),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 18,
//                                                           ),
//                                                           Text(
//                                                               'S’il vous plaît laissez-nous savoir les raisons',
//                                                               style: GoogleFonts
//                                                                   .roboto(
//                                                                 textStyle:
//                                                                     const TextStyle(
//                                                                   fontSize: 14,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color:
//                                                                       AppConstants
//                                                                           .gray1,
//                                                                 ),
//                                                               )),
//                                                           SizedBox(
//                                                             height: 18,
//                                                           ),
//                                                           // Wrap(children: [
//                                                           //   ChoiceChip(
//                                                           //     label: Text(
//                                                           //       'La Communication',
//                                                           //       style: TextStyle(
//                                                           //           color: communication ==
//                                                           //                   'La Communication'
//                                                           //               ? const Color.fromARGB(
//                                                           //                   255,
//                                                           //                   246,
//                                                           //                   210,
//                                                           //                   210)
//                                                           //               : Colors
//                                                           //                   .black),
//                                                           //     ),
//                                                           //     selected:
//                                                           //         communication ==
//                                                           //             'La Communication',
//                                                           //     onSelected:
//                                                           //         (selected) {
//                                                           //       setState(() {
//                                                           //         communication =
//                                                           //             selected
//                                                           //                 ? 'La Communication'
//                                                           //                 : '';
//                                                           //       });
//                                                           //     },
//                                                           //     side: BorderSide(
//                                                           //         color: AppConstants
//                                                           //             .line
//                                                           //             .withOpacity(
//                                                           //                 0.32)),
//                                                           //     backgroundColor: communication ==
//                                                           //             'La Communication'
//                                                           //         ? AppConstants
//                                                           //             .critical
//                                                           //         : Colors
//                                                           //             .transparent,
//                                                           //     selectedColor:
//                                                           //         AppConstants
//                                                           //             .critical,
//                                                           //   ),
//                                                           //   const SizedBox(
//                                                           //     width: 10,
//                                                           //   ),
//                                                           //   ChoiceChip(
//                                                           //     label: Text(
//                                                           //       'professionnalisme',
//                                                           //       style: TextStyle(
//                                                           //           color: professionnalisme ==
//                                                           //                   'professionnalisme'
//                                                           //               ? const Color.fromARGB(
//                                                           //                   255,
//                                                           //                   246,
//                                                           //                   210,
//                                                           //                   210)
//                                                           //               : Colors
//                                                           //                   .black),
//                                                           //     ),
//                                                           //     selected:
//                                                           //         professionnalisme ==
//                                                           //             'professionnalisme',
//                                                           //     onSelected:
//                                                           //         (selected) {
//                                                           //       setState(() {
//                                                           //         professionnalisme =
//                                                           //             selected
//                                                           //                 ? 'professionnalisme'
//                                                           //                 : '';
//                                                           //       });
//                                                           //     },
//                                                           //     side: BorderSide(
//                                                           //         color: AppConstants
//                                                           //             .line
//                                                           //             .withOpacity(
//                                                           //                 0.32)),
//                                                           //     backgroundColor: professionnalisme ==
//                                                           //             'professionnalisme'
//                                                           //         ? AppConstants
//                                                           //             .critical
//                                                           //         : Colors
//                                                           //             .transparent,
//                                                           //     selectedColor:
//                                                           //         AppConstants
//                                                           //             .critical,
//                                                           //   ),
//                                                           //   ChoiceChip(
//                                                           //     label: Text(
//                                                           //       'utile',
//                                                           //       style: TextStyle(
//                                                           //           color: utile ==
//                                                           //                   'utile'
//                                                           //               ? const Color.fromARGB(
//                                                           //                   255,
//                                                           //                   246,
//                                                           //                   210,
//                                                           //                   210)
//                                                           //               : Colors
//                                                           //                   .black),
//                                                           //     ),
//                                                           //     selected: utile ==
//                                                           //         'utile',
//                                                           //     onSelected:
//                                                           //         (selected) {
//                                                           //       setState(() {
//                                                           //         utile = selected
//                                                           //             ? 'utile'
//                                                           //             : '';
//                                                           //       });
//                                                           //     },
//                                                           //     side: BorderSide(
//                                                           //         color: AppConstants
//                                                           //             .line
//                                                           //             .withOpacity(
//                                                           //                 0.32)),
//                                                           //     backgroundColor: utile ==
//                                                           //             'utile'
//                                                           //         ? AppConstants
//                                                           //             .critical
//                                                           //         : Colors
//                                                           //             .transparent,
//                                                           //     selectedColor:
//                                                           //         AppConstants
//                                                           //             .critical,
//                                                           //   ),
//                                                           //   const SizedBox(
//                                                           //     width: 10,
//                                                           //   ),
//                                                           //   ChoiceChip(
//                                                           //     label: Text(
//                                                           //       'amical',
//                                                           //       style: TextStyle(
//                                                           //           color: amical ==
//                                                           //                   'amical'
//                                                           //               ? const Color.fromARGB(
//                                                           //                   255,
//                                                           //                   246,
//                                                           //                   210,
//                                                           //                   210)
//                                                           //               : Colors
//                                                           //                   .black),
//                                                           //     ),
//                                                           //     selected:
//                                                           //         amical ==
//                                                           //             'amical',
//                                                           //     onSelected:
//                                                           //         (selected) {
//                                                           //       setState(() {
//                                                           //         amical = selected
//                                                           //             ? 'amical'
//                                                           //             : '';
//                                                           //       });
//                                                           //     },
//                                                           //     side: BorderSide(
//                                                           //         color: AppConstants
//                                                           //             .line
//                                                           //             .withOpacity(
//                                                           //                 0.32)),
//                                                           //     backgroundColor:
//                                                           //         amical ==
//                                                           //                 'amical'
//                                                           //             ? AppConstants
//                                                           //                 .critical
//                                                           //             : Colors
//                                                           //                 .transparent,
//                                                           //     selectedColor:
//                                                           //         AppConstants
//                                                           //             .critical,
//                                                           //   ),
//                                                           //   const SizedBox(
//                                                           //     width: 10,
//                                                           //   ),
//                                                           //   ChoiceChip(
//                                                           //     label: Text(
//                                                           //       'respectueux',
//                                                           //       style: TextStyle(
//                                                           //           color: respectueux ==
//                                                           //                   'respectueux'
//                                                           //               ? const Color.fromARGB(
//                                                           //                   255,
//                                                           //                   246,
//                                                           //                   210,
//                                                           //                   210)
//                                                           //               : Colors
//                                                           //                   .black),
//                                                           //     ),
//                                                           //     selected:
//                                                           //         respectueux ==
//                                                           //             'respectueux',
//                                                           //     onSelected:
//                                                           //         (selected) {
//                                                           //       setState(() {
//                                                           //         respectueux =
//                                                           //             selected
//                                                           //                 ? 'respectueux'
//                                                           //                 : '';
//                                                           //       });
//                                                           //     },
//                                                           //     side: BorderSide(
//                                                           //         color: AppConstants
//                                                           //             .line
//                                                           //             .withOpacity(
//                                                           //                 0.32)),
//                                                           //     backgroundColor: respectueux ==
//                                                           //             'respectueux'
//                                                           //         ? AppConstants
//                                                           //             .critical
//                                                           //         : Colors
//                                                           //             .transparent,
//                                                           //     selectedColor:
//                                                           //         AppConstants
//                                                           //             .critical,
//                                                           //   ),
//                                                           //   const SizedBox(
//                                                           //     width: 10,
//                                                           //   ),
//                                                           // ]),

//                                                           Padding(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         8,
//                                                                     vertical:
//                                                                         16),
//                                                             child: TextField(
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                                 hintText:
//                                                                     'Ajouter des détails (optionnel)',
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 20,
//                                                           ),
//                                                           Container(
//                                                             width:
//                                                                 MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                             height: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .height *
//                                                                 0.07,
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           16.0,
//                                                                       right:
//                                                                           16),
//                                                               child: TextButton(
//                                                                 onPressed: () {
//                                                                   Navigator.of(
//                                                                           context)
//                                                                       .pop();
//                                                                   showDialog(
//                                                                     context:
//                                                                         context,
//                                                                     builder: (BuildContext
//                                                                             context) =>
//                                                                         ReportAlert(),
//                                                                   );
//                                                                 },
//                                                                 style: TextButton.styleFrom(
//                                                                     backgroundColor:
//                                                                         AppConstants
//                                                                             .critical,
//                                                                     shape: RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(35))),
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                               .fromLTRB(
//                                                                           80,
//                                                                           5,
//                                                                           80,
//                                                                           5),
//                                                                   child: Text(
//                                                                       'Rapport utilisateur',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                               textStyle: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w600,
//                                                                         color: AppConstants
//                                                                             .white,
//                                                                       ))),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               child: Text(
//                                                   "Signaler l’utilisateur",
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: const TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       color: Color(0xFF0A84FF),
//                                                     ),
//                                                   )),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 // Navigator.of(context)
//                                                 //     .pushReplacement(MaterialPageRoute<void>(
//                                                 //   builder: (BuildContext context) =>
//                                                 //       const StartScreen(),
//                                                 // ));
//                                               },
//                                               child: Text("Unmatch",
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: const TextStyle(
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   )),
//                                             ),
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 showModalBottomSheet<void>(
//                                                   shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.vertical(
//                                                             top:
//                                                                 Radius.circular(
//                                                                     13.0)),
//                                                   ),
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) {
//                                                     return SizedBox(
//                                                       height: 400,
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                         children: <Widget>[
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           16.0),
//                                                               child: Text(
//                                                                   'Évaluer ' +
//                                                                       widget
//                                                                           .client
//                                                                           .fullName
//                                                                           .toUpperCase(),
//                                                                   style:
//                                                                       GoogleFonts
//                                                                           .teko(
//                                                                     textStyle: const TextStyle(
//                                                                         fontSize:
//                                                                             24,
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w600,
//                                                                         color: AppConstants
//                                                                             .gray1),
//                                                                   )),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 18,
//                                                           ),
//                                                           Text(
//                                                               'Comment était l’activité avec ' +
//                                                                   widget.client
//                                                                       .fullName,
//                                                               style: GoogleFonts
//                                                                   .roboto(
//                                                                 textStyle:
//                                                                     const TextStyle(
//                                                                   fontSize: 14,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color:
//                                                                       AppConstants
//                                                                           .gray1,
//                                                                 ),
//                                                               )),
//                                                           SizedBox(
//                                                             height: 18,
//                                                           ),
//                                                           RatingBar.builder(
//                                                             initialRating: 1,
//                                                             minRating: 1,
//                                                             direction:
//                                                                 Axis.horizontal,
//                                                             allowHalfRating:
//                                                                 true,
//                                                             itemCount: 5,
//                                                             itemPadding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         4.0),
//                                                             itemBuilder:
//                                                                 (context, _) =>
//                                                                     Icon(
//                                                               Icons.star,
//                                                               color: Color(
//                                                                   0xFFFD4755),
//                                                             ),
//                                                             onRatingUpdate:
//                                                                 (rating) {
//                                                               print(rating);
//                                                             },
//                                                           ),
//                                                           SizedBox(
//                                                             height: 18,
//                                                           ),
//                                                           Wrap(children: [
//                                                             ChoiceChip(
//                                                               label: Text(
//                                                                 'La Communication',
//                                                                 style: TextStyle(
//                                                                     color: communication ==
//                                                                             'La Communication'
//                                                                         ? const Color.fromARGB(
//                                                                             255,
//                                                                             246,
//                                                                             210,
//                                                                             210)
//                                                                         : Colors
//                                                                             .black),
//                                                               ),
//                                                               selected:
//                                                                   communication ==
//                                                                       'La Communication',
//                                                               onSelected:
//                                                                   (selected) {
//                                                                 setState(() {
//                                                                   communication =
//                                                                       selected
//                                                                           ? 'La Communication'
//                                                                           : '';
//                                                                 });
//                                                               },
//                                                               side: BorderSide(
//                                                                   color: AppConstants
//                                                                       .line
//                                                                       .withOpacity(
//                                                                           0.32)),
//                                                               backgroundColor: communication ==
//                                                                       'La Communication'
//                                                                   ? AppConstants
//                                                                       .critical
//                                                                   : Colors
//                                                                       .transparent,
//                                                               selectedColor:
//                                                                   AppConstants
//                                                                       .critical,
//                                                             ),
//                                                             const SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             ChoiceChip(
//                                                               label: Text(
//                                                                 'professionnalisme',
//                                                                 style: TextStyle(
//                                                                     color: professionnalisme ==
//                                                                             'professionnalisme'
//                                                                         ? const Color.fromARGB(
//                                                                             255,
//                                                                             246,
//                                                                             210,
//                                                                             210)
//                                                                         : Colors
//                                                                             .black),
//                                                               ),
//                                                               selected:
//                                                                   professionnalisme ==
//                                                                       'professionnalisme',
//                                                               onSelected:
//                                                                   (selected) {
//                                                                 setState(() {
//                                                                   professionnalisme =
//                                                                       selected
//                                                                           ? 'professionnalisme'
//                                                                           : '';
//                                                                 });
//                                                               },
//                                                               side: BorderSide(
//                                                                   color: AppConstants
//                                                                       .line
//                                                                       .withOpacity(
//                                                                           0.32)),
//                                                               backgroundColor: professionnalisme ==
//                                                                       'professionnalisme'
//                                                                   ? AppConstants
//                                                                       .critical
//                                                                   : Colors
//                                                                       .transparent,
//                                                               selectedColor:
//                                                                   AppConstants
//                                                                       .critical,
//                                                             ),
//                                                             ChoiceChip(
//                                                               label: Text(
//                                                                 'utile',
//                                                                 style: TextStyle(
//                                                                     color: utile ==
//                                                                             'utile'
//                                                                         ? const Color.fromARGB(
//                                                                             255,
//                                                                             246,
//                                                                             210,
//                                                                             210)
//                                                                         : Colors
//                                                                             .black),
//                                                               ),
//                                                               selected: utile ==
//                                                                   'utile',
//                                                               onSelected:
//                                                                   (selected) {
//                                                                 setState(() {
//                                                                   utile = selected
//                                                                       ? 'utile'
//                                                                       : '';
//                                                                 });
//                                                               },
//                                                               side: BorderSide(
//                                                                   color: AppConstants
//                                                                       .line
//                                                                       .withOpacity(
//                                                                           0.32)),
//                                                               backgroundColor: utile ==
//                                                                       'utile'
//                                                                   ? AppConstants
//                                                                       .critical
//                                                                   : Colors
//                                                                       .transparent,
//                                                               selectedColor:
//                                                                   AppConstants
//                                                                       .critical,
//                                                             ),
//                                                             const SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             ChoiceChip(
//                                                               label: Text(
//                                                                 'amical',
//                                                                 style: TextStyle(
//                                                                     color: amical ==
//                                                                             'amical'
//                                                                         ? const Color.fromARGB(
//                                                                             255,
//                                                                             246,
//                                                                             210,
//                                                                             210)
//                                                                         : Colors
//                                                                             .black),
//                                                               ),
//                                                               selected:
//                                                                   amical ==
//                                                                       'amical',
//                                                               onSelected:
//                                                                   (selected) {
//                                                                 setState(() {
//                                                                   amical = selected
//                                                                       ? 'amical'
//                                                                       : '';
//                                                                 });
//                                                               },
//                                                               side: BorderSide(
//                                                                   color: AppConstants
//                                                                       .line
//                                                                       .withOpacity(
//                                                                           0.32)),
//                                                               backgroundColor:
//                                                                   amical ==
//                                                                           'amical'
//                                                                       ? AppConstants
//                                                                           .critical
//                                                                       : Colors
//                                                                           .transparent,
//                                                               selectedColor:
//                                                                   AppConstants
//                                                                       .critical,
//                                                             ),
//                                                             const SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                             ChoiceChip(
//                                                               label: Text(
//                                                                 'respectueux',
//                                                                 style: TextStyle(
//                                                                     color: respectueux ==
//                                                                             'respectueux'
//                                                                         ? const Color.fromARGB(
//                                                                             255,
//                                                                             246,
//                                                                             210,
//                                                                             210)
//                                                                         : Colors
//                                                                             .black),
//                                                               ),
//                                                               selected:
//                                                                   respectueux ==
//                                                                       'respectueux',
//                                                               onSelected:
//                                                                   (selected) {
//                                                                 setState(() {
//                                                                   respectueux =
//                                                                       selected
//                                                                           ? 'respectueux'
//                                                                           : '';
//                                                                 });
//                                                               },
//                                                               side: BorderSide(
//                                                                   color: AppConstants
//                                                                       .line
//                                                                       .withOpacity(
//                                                                           0.32)),
//                                                               backgroundColor: respectueux ==
//                                                                       'respectueux'
//                                                                   ? AppConstants
//                                                                       .critical
//                                                                   : Colors
//                                                                       .transparent,
//                                                               selectedColor:
//                                                                   AppConstants
//                                                                       .critical,
//                                                             ),
//                                                             const SizedBox(
//                                                               width: 10,
//                                                             ),
//                                                           ]),
//                                                           Padding(
//                                                             padding: EdgeInsets
//                                                                 .symmetric(
//                                                                     horizontal:
//                                                                         8,
//                                                                     vertical:
//                                                                         16),
//                                                             child: TextField(
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 border:
//                                                                     OutlineInputBorder(),
//                                                                 hintText:
//                                                                     'Ajouter des détails (optionnel)',
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 10,
//                                                           ),
//                                                           Container(
//                                                             width:
//                                                                 MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width,
//                                                             height: MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .height *
//                                                                 0.07,
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                           .only(
//                                                                       left:
//                                                                           16.0,
//                                                                       right:
//                                                                           16),
//                                                               child: TextButton(
//                                                                 onPressed: () {
//                                                                   Navigator.of(
//                                                                           context)
//                                                                       .pop();
//                                                                   showDialog(
//                                                                     context:
//                                                                         context,
//                                                                     builder: (BuildContext
//                                                                             context) =>
//                                                                         ReviewAlert(),
//                                                                   );
//                                                                 },
//                                                                 style: TextButton.styleFrom(
//                                                                     backgroundColor:
//                                                                         AppConstants
//                                                                             .critical,
//                                                                     shape: RoundedRectangleBorder(
//                                                                         borderRadius:
//                                                                             BorderRadius.circular(35))),
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                               .fromLTRB(
//                                                                           50,
//                                                                           5,
//                                                                           50,
//                                                                           5),
//                                                                   child: Text(
//                                                                       'Envoyer des commentaires',
//                                                                       style: GoogleFonts
//                                                                           .poppins(
//                                                                               textStyle: TextStyle(
//                                                                         fontSize:
//                                                                             16,
//                                                                         fontWeight:
//                                                                             FontWeight.w600,
//                                                                         color: AppConstants
//                                                                             .white,
//                                                                       ))),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               child: Text(
//                                                   "Évaluer ce compagnon",
//                                                   style: GoogleFonts.roboto(
//                                                     textStyle: const TextStyle(
//                                                       color: Color(0xFF0A84FF),
//                                                       fontSize: 20,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                     ),
//                                                   )),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                                 /*
//                             Navigator.of(context)
//                                 .pushReplacement(MaterialPageRoute<void>(
//                               builder: (BuildContext context) =>
//                                   const StartScreen(),
//                             ));*/
//                               },
//                               iconSize: 24,
//                               color: AppConstants.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                   alignment: Alignment.center,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 32),
//                       Row(
//                         children: [
//                           Text(
//                             widget.client.fullName.toUpperCase(),
//                             style: GoogleFonts.teko(
//                               textStyle: TextStyle(
//                                 fontSize: 32,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppConstants.line,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Icon(
//                             Icons.verified,
//                             color: Color(0xFF3897F0),
//                             size: 30,
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'À propos'.toUpperCase(),
//                         style: GoogleFonts.teko(
//                           color: AppConstants.gray1,
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                           height: 0.06,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       Text(
//                         'Créer un lien dynamique entre les entraîneurs et les amateurs de bien-être et d’art à travers des communautés aux vues similaires pour cultiver un environnement harmonieux et inspirant.',
//                         style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           color: AppConstants.gray1,
//                         ),
//                         textAlign: TextAlign.justify,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 3,
//                       ),
//                       SizedBox(height: 15),
//                       Row(
//                         children: [
//                           Chip(
//                             backgroundColor: Colors.transparent,
//                             label: Text('Style de vie sain'),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                               side: BorderSide(
//                                 width: 1,
//                                 color: Color.fromRGBO(145, 158, 171, 0.32),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 25,
//                           ),
//                           Chip(
//                             label: Text('Santé mentale'),
//                             backgroundColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                               side: BorderSide(
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Chip(
//                         label: Text('Construction du corps'),
//                         backgroundColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                           side: BorderSide(
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 45,
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: Color.fromARGB(255, 251, 236, 236),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Icon(
//                                   Icons.close,
//                                   size: 30,
//                                   color: AppConstants.critical,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 16,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.of(context).push(MaterialPageRoute<void>(
//                                   //   builder: (BuildContext context) =>
//                                   //       const MatchedFilterScreen(),
//                                   // ));
//                                 },
//                                 child: Container(
//                                   width: 45,
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(253, 71, 85, 0.43),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: IconButton(
//                                     icon: SvgPicture.asset(
//                                       'assets/images/heart.svg',
//                                       color: Color(0xFFFD4755),
//                                     ),
//                                     onPressed: () {},
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
