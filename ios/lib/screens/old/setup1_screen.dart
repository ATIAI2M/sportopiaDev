// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/screens/auth/setup2_screen.dart';
// import 'package:testapp/screens/auth/start_screen.dart';

// import '../../providers/data_provider.dart';

// class Setup1Screen extends StatefulWidget {
//   const Setup1Screen({Key? key}) : super(key: key);

//   @override
//   _Setup1ScreenState createState() => _Setup1ScreenState();
// }

// class _Setup1ScreenState extends State<Setup1Screen> {
//   bool light = false;
//   String goal = '';
//   String interests = '';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         width: 1,
//                         color: AppConstants.line,
//                       ),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back_ios_new),
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacement(MaterialPageRoute<void>(
//                           builder: (BuildContext context) =>
//                               const StartScreen(),
//                         ));
//                       },
//                       iconSize: 24,
//                       color: AppConstants.black,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 60,
//                   ),
//                   Container(
//                     width: 28,
//                     height: 4,
//                     decoration: ShapeDecoration(
//                       color: AppConstants.critical,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(104),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 4,
//                   ),
//                   Container(
//                     width: 28,
//                     height: 4,
//                     decoration: ShapeDecoration(
//                       color: AppConstants.line,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(104),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 4,
//                   ),
//                   Container(
//                     width: 28,
//                     height: 4,
//                     decoration: ShapeDecoration(
//                       color: AppConstants.line,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(104),
//                       ),
//                     ),
//                   ),
//                   Expanded(child: Container()),
//                   Text(
//                     '1/3',
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.teko(
//                       color: Color(0xFFA2A5B1),
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       height: 0.09,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Quel est votre objectif?'.toUpperCase(),
//                   style: GoogleFonts.teko(
//                     color: Color(0xFF202226),
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                     height: 0.06,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 32,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Wrap(
//                   children: [
//                     ChoiceChip(
//                       label: Text(
//                         'Perdre du poids',
//                         style: TextStyle(
//                             color: goal == 'Perdre du poids'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: goal == 'Perdre du poids',
//                       onSelected: (selected) {
//                         setState(() {
//                           goal = selected ? 'Perdre du poids' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: goal == 'Perdre du poids'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Soyez plus en forme',
//                         style: TextStyle(
//                             color: goal == 'Soyez plus en forme'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: goal == 'Soyez plus en forme',
//                       onSelected: (selected) {
//                         setState(() {
//                           goal = selected ? 'Soyez plus en forme' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: goal == 'Soyez plus en forme'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Gagner du muscle',
//                         style: TextStyle(
//                             color: goal == 'Gagner du muscle'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: goal == 'Gagner du muscle',
//                       onSelected: (selected) {
//                         setState(() {
//                           goal = selected ? 'Gagner du muscle' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: goal == 'Gagner du muscle'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 70,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'Vos intérêts'.toUpperCase(),
//                     style: GoogleFonts.teko(
//                       color: Color(0xFF202226),
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Wrap(
//                   children: [
//                     ChoiceChip(
//                       label: Text(
//                         'bien-être',
//                         style: TextStyle(
//                             color: interests == 'bien-être'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: interests == 'bien-être',
//                       onSelected: (selected) {
//                         setState(() {
//                           interests = selected ? 'bien-être' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: interests == 'bien-être'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Style de vie sain',
//                         style: TextStyle(
//                             color: interests == 'Style de vie sain'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: interests == 'Style de vie sain',
//                       onSelected: (selected) {
//                         setState(() {
//                           interests = selected ? 'Style de vie sain' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: interests == 'Style de vie sain'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Santé mentale',
//                         style: TextStyle(
//                             color: interests == 'Santé mentale'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: interests == 'Santé mentale',
//                       onSelected: (selected) {
//                         setState(() {
//                           interests = selected ? 'Santé mentale' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: interests == 'Santé mentale'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Construction du corps',
//                         style: TextStyle(
//                             color: interests == 'Construction du corps'
//                                 ? Colors.white
//                                 : Colors.black),
//                       ),
//                       selected: interests == 'Construction du corps',
//                       onSelected: (selected) {
//                         setState(() {
//                           interests = selected ? 'Construction du corps' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: interests == 'Construction du corps'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Êtes-vous un athlète professionnel?'.toUpperCase(),
//                   //textAlign: TextAlign.start,
//                   style: GoogleFonts.teko(
//                     color: Color(0xFF202226),
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 children: [
//                   Text('Oui, je suis un athlète professionnel',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//                   Expanded(
//                     child: Container(),
//                   ),
//                   Switch(
//                       value: light,
//                       activeColor: AppConstants.critical,
//                       onChanged: (bool value) {
//                         setState(() {
//                           light = value;
//                         });
//                       })
//                 ],
//               ),
//               Expanded(child: Container()),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 child: TextButton(
//                   onPressed: () {
//                     //Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);
//                     Navigator.of(context).push(MaterialPageRoute<void>(
//                       builder: (BuildContext context) => Setup2Screen(
//                           light: light, goal: goal, interests: interests),
//                     ));
//                   },
//                   style: TextButton.styleFrom(
//                       backgroundColor: AppConstants.critical,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35))),
//                   child: Text('Etape suivante',
//                       style: GoogleFonts.poppins(
//                           textStyle: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppConstants.white,
//                       ))),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
