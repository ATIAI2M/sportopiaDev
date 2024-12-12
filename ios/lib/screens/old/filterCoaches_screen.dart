// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';

// import 'package:testapp/screens/old/findCoachesEmpty_screen.dart';

// class FilterCoaches extends StatefulWidget {
//   const FilterCoaches({super.key});

//   @override
//   State<FilterCoaches> createState() => _FilterCoachesState();
// }

// class _FilterCoachesState extends State<FilterCoaches> {
//   double SliderValue = 2;
//   double SliderBudget = 20;
//   String gender = '';
//   String interests = '';
//   String ranking = '';
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // margin: const EdgeInsets.all(16),
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
//                         Navigator.of(context).pop();
//                       },
//                       iconSize: 24,
//                       color: AppConstants.black,
//                     ),
//                   ),
//                   Expanded(child: Container()),
//                   // SizedBox(
//                   //   width: 50,
//                   // ),
//                   Text(
//                     'FILTER RESULTS',
//                     style: GoogleFonts.teko(
//                       textStyle: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFFA6A6A6),
//                       ),
//                     ),
//                   ),
//                   Expanded(child: Container()),
//                 ],
//               ),
//               SizedBox(
//                 height: 64,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'DISTANCE PREFERENCE',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                   Expanded(child: Container()),
//                   Text(
//                     '16 KM',
//                     style: GoogleFonts.poppins(
//                       color: AppConstants.gray1,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       height: 0.06,
//                     ),
//                   ),
//                 ],
//               ),
//               Slider(
//                   activeColor: AppConstants.critical,
//                   inactiveColor: AppConstants.line,
//                   value: SliderValue,
//                   max: 32,
//                   label: SliderValue.round().toString(),
//                   onChanged: (double value) {
//                     setState(() {
//                       SliderValue = value;
//                     });
//                   }),
//               SizedBox(
//                 height: 56,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'COMPANION GENDER',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                   Wrap(children: [
//                     ChoiceChip(
//                       label: Text(
//                         'Man',
//                         style: TextStyle(
//                             color: gender == 'Man'
//                                 ? const Color.fromARGB(255, 246, 210, 210)
//                                 : Colors.black),
//                       ),
//                       selected: gender == 'Man',
//                       onSelected: (selected) {
//                         setState(() {
//                           gender = selected ? 'Man' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: gender == 'Man'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     ChoiceChip(
//                       label: Text(
//                         'Woman',
//                         style: TextStyle(
//                             color: gender == 'Woman'
//                                 ? const Color.fromARGB(255, 246, 210, 210)
//                                 : Colors.black),
//                       ),
//                       selected: gender == 'Woman',
//                       onSelected: (selected) {
//                         setState(() {
//                           gender = selected ? 'Woman' : '';
//                         });
//                       },
//                       side: BorderSide(
//                           color: AppConstants.line.withOpacity(0.32)),
//                       backgroundColor: gender == 'Woman'
//                           ? AppConstants.critical
//                           : Colors.transparent,
//                       selectedColor: AppConstants.critical,
//                     ),
//                   ]),
//                 ],
//               ),
//               SizedBox(
//                 height: 56,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'COACH SPECIALITIES',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 32,
//               ),
//               Column(
//                 children: [
//                   Wrap(
//                     children: [
//                       ChoiceChip(
//                         label: Text(
//                           'Wellbeing',
//                           style: TextStyle(
//                               color: interests == 'Wellbeing'
//                                   ? const Color.fromARGB(255, 246, 210, 210)
//                                   : Colors.black),
//                         ),
//                         selected: interests == 'Wellbeing',
//                         onSelected: (selected) {
//                           setState(() {
//                             interests = selected ? 'Wellbeing' : '';
//                           });
//                         },
//                         side: BorderSide(
//                             color: AppConstants.line.withOpacity(0.32)),
//                         backgroundColor: interests == 'Wellbeing'
//                             ? AppConstants.critical
//                             : Colors.transparent,
//                         selectedColor: AppConstants.critical,
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       ChoiceChip(
//                         label: Text(
//                           'Healthy life-style',
//                           style: TextStyle(
//                               color: interests == 'Healthy life-style'
//                                   ? const Color.fromARGB(255, 246, 210, 210)
//                                   : Colors.black),
//                         ),
//                         selected: interests == 'Healthy life-style',
//                         onSelected: (selected) {
//                           setState(() {
//                             interests = selected ? 'Healthy life-style' : '';
//                           });
//                         },
//                         side: BorderSide(
//                             color: AppConstants.line.withOpacity(0.32)),
//                         backgroundColor: interests == 'Healthy life-style'
//                             ? AppConstants.critical
//                             : Colors.transparent,
//                         selectedColor: AppConstants.critical,
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       ChoiceChip(
//                         label: Text(
//                           'Mental health',
//                           style: TextStyle(
//                               color: interests == 'Mental health'
//                                   ? const Color.fromARGB(255, 246, 210, 210)
//                                   : Colors.black),
//                         ),
//                         selected: interests == 'Mental health',
//                         onSelected: (selected) {
//                           setState(() {
//                             interests = selected ? 'Mental health' : '';
//                           });
//                         },
//                         side: BorderSide(
//                             color: AppConstants.line.withOpacity(0.32)),
//                         backgroundColor: interests == 'Mental health'
//                             ? AppConstants.critical
//                             : Colors.transparent,
//                         selectedColor: AppConstants.critical,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 56,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'COACH ranking'.toUpperCase(),
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
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
//               Wrap(
//                 children: [
//                   ChoiceChip(
//                     label: Text(
//                       'Master coach',
//                       style: TextStyle(
//                           color: ranking == 'Master coach'
//                               ? const Color.fromARGB(255, 246, 210, 210)
//                               : Colors.black),
//                     ),
//                     selected: ranking == 'Master coach',
//                     onSelected: (selected) {
//                       setState(() {
//                         ranking = selected ? 'Master coach' : '';
//                       });
//                     },
//                     side:
//                         BorderSide(color: AppConstants.line.withOpacity(0.32)),
//                     backgroundColor: interests == 'Master coach'
//                         ? AppConstants.critical
//                         : Colors.transparent,
//                     selectedColor: AppConstants.critical,
//                   ),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   ChoiceChip(
//                     label: Text(
//                       'Golden coach',
//                       style: TextStyle(
//                           color: ranking == 'Golden coach'
//                               ? const Color.fromARGB(255, 246, 210, 210)
//                               : Colors.black),
//                     ),
//                     selected: ranking == 'Golden coach',
//                     onSelected: (selected) {
//                       setState(() {
//                         ranking = selected ? 'Golden coach' : '';
//                       });
//                     },
//                     side:
//                         BorderSide(color: AppConstants.line.withOpacity(0.32)),
//                     backgroundColor: interests == 'Golden coach'
//                         ? AppConstants.critical
//                         : Colors.transparent,
//                     selectedColor: AppConstants.critical,
//                   ),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   ChoiceChip(
//                     label: Text(
//                       'Star trainer',
//                       style: TextStyle(
//                           color: ranking == 'Star trainer'
//                               ? const Color.fromARGB(255, 246, 210, 210)
//                               : Colors.black),
//                     ),
//                     selected: ranking == 'Star trainer',
//                     onSelected: (selected) {
//                       setState(() {
//                         ranking = selected ? 'Star trainer' : '';
//                       });
//                     },
//                     side:
//                         BorderSide(color: AppConstants.line.withOpacity(0.32)),
//                     backgroundColor: interests == 'Star trainer'
//                         ? AppConstants.critical
//                         : Colors.transparent,
//                     selectedColor: AppConstants.critical,
//                   ),
//                   ChoiceChip(
//                     label: Text(
//                       'body-building',
//                       style: TextStyle(
//                           color: interests == 'body-building'
//                               ? const Color.fromARGB(255, 246, 210, 210)
//                               : Colors.black),
//                     ),
//                     selected: interests == 'body-building',
//                     onSelected: (selected) {
//                       setState(() {
//                         interests = selected ? 'body-building' : '';
//                       });
//                     },
//                     side:
//                         BorderSide(color: AppConstants.line.withOpacity(0.32)),
//                     backgroundColor: interests == 'body-building'
//                         ? AppConstants.critical
//                         : Colors.transparent,
//                     selectedColor: AppConstants.critical,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 56,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     'BUDGET PREFERENCE',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                   Expanded(child: Container()),
//                   Text(
//                     '390 TND / Month',
//                     style: GoogleFonts.poppins(
//                       color: AppConstants.gray1,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       height: 0.06,
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(
//               //   height: 32,
//               // ),a
//               Slider(
//                   activeColor: AppConstants.critical,
//                   inactiveColor: AppConstants.line,
//                   value: SliderBudget,
//                   max: 1000,
//                   // divisions: 8,
//                   label: SliderBudget.round().toString(),
//                   onChanged: (double value) {
//                     setState(() {
//                       SliderBudget = value;
//                     });
//                   }),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.07,
//                 child: TextButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute<void>(
//                       builder: (BuildContext context) =>
//                           const FindCoachesEmpty(),
//                     ));
//                   },
//                   style: TextButton.styleFrom(
//                       backgroundColor: AppConstants.critical,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35))),
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(100, 5, 100, 5),
//                     child: Text('Apply filters',
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppConstants.white,
//                         ))),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
