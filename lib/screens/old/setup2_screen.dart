// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/screens/auth/setup1_screen.dart';
// import 'package:testapp/screens/auth/activate_location_screen.dart';

// class Setup2Screen extends StatefulWidget {
//   final bool light;
//   final String goal;
//   final String interests;
//   const Setup2Screen(
//       {super.key,
//       required this.light,
//       required this.goal,
//       required this.interests});

//   @override
//   State<Setup2Screen> createState() => _Setup2ScreenState();
// }

// class _Setup2ScreenState extends State<Setup2Screen> {
//   //late bool light ;
//   String gender = '';

//   TextEditingController agecontroller = TextEditingController();
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController phonecontroller = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (FirebaseAuth.instance.currentUser != null) {
//       namecontroller.text = FirebaseAuth.instance.currentUser!.displayName!;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           width: 1,
//                           color: AppConstants.line,
//                         ),
//                       ),
//                       child: IconButton(
//                         icon: Icon(Icons.arrow_back_ios_new),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute<void>(
//                             builder: (BuildContext context) =>
//                                 const Setup1Screen(),
//                           ));
//                         },
//                         iconSize: 24,
//                         color: AppConstants.black,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 60,
//                     ),
//                     Container(
//                       width: 28,
//                       height: 4,
//                       decoration: ShapeDecoration(
//                         color: AppConstants.line,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(104),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Container(
//                       width: 28,
//                       height: 4,
//                       decoration: ShapeDecoration(
//                         color: AppConstants.critical,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(104),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 4,
//                     ),
//                     Container(
//                       width: 28,
//                       height: 4,
//                       decoration: ShapeDecoration(
//                         color: AppConstants.line,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(104),
//                         ),
//                       ),
//                     ),
//                     Expanded(child: Container()),
//                     Text(
//                       '2/3',
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.teko(
//                         color: Color(0xFFA2A5B1),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         height: 0.09,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 8,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   controller: namecontroller,
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     color: Colors.black,
//                   ),
//                   decoration: const InputDecoration(
//                     border: UnderlineInputBorder(),
//                     labelText: 'Nom Prenom',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.phone,
//                   controller: phonecontroller,
//                   style: GoogleFonts.poppins(
//                     textStyle: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     color: Colors.black,
//                   ),
//                   decoration: const InputDecoration(
//                     border: UnderlineInputBorder(),
//                     labelText: 'Télephone',
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Quel est votre sexe'.toUpperCase(),
//                       style: GoogleFonts.teko(
//                         color: Color(0xFF202226),
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         height: 0.06,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Wrap(children: [
//                       ChoiceChip(
//                         label: Text(
//                           'Homme',
//                           style: TextStyle(
//                               color: gender == 'Homme'
//                                   ? const Color.fromARGB(255, 246, 210, 210)
//                                   : Colors.black),
//                         ),
//                         selected: gender == 'Homme',
//                         onSelected: (selected) {
//                           setState(() {
//                             gender = selected ? 'Homme' : '';
//                           });
//                         },
//                         side: BorderSide(
//                             color: AppConstants.line.withOpacity(0.32)),
//                         backgroundColor: gender == 'Homme'
//                             ? AppConstants.critical
//                             : Colors.transparent,
//                         selectedColor: AppConstants.critical,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       ChoiceChip(
//                         label: Text(
//                           'Femme',
//                           style: TextStyle(
//                               color: gender == 'Femme'
//                                   ? const Color.fromARGB(255, 246, 210, 210)
//                                   : Colors.black),
//                         ),
//                         selected: gender == 'Femme',
//                         onSelected: (selected) {
//                           setState(() {
//                             gender = selected ? 'Femme' : '';
//                           });
//                         },
//                         side: BorderSide(
//                             color: AppConstants.line.withOpacity(0.32)),
//                         backgroundColor: gender == 'Femme'
//                             ? AppConstants.critical
//                             : Colors.transparent,
//                         selectedColor: AppConstants.critical,
//                       ),
//                     ]),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Quel est votre âge'.toUpperCase(),
//                       //textAlign: TextAlign.start,
//                       style: GoogleFonts.teko(
//                         color: Color(0xFF202226),
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                         height: 0.06,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 64,
//                 ),
//                 TextField(
//                   controller: agecontroller,
//                   showCursor: false,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                   ],
//                   style: GoogleFonts.teko(
//                     color: Color(0xFF202226),
//                     fontSize: 96,
//                     fontWeight: FontWeight.w600,
//                     height: 0.06,
//                   ),
//                 ),
//                 //Expanded(child: Container()),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height * 0.07,
//                   child: TextButton(
//                     onPressed: () {
//                       //Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);
//                       // Navigator.of(context).push(MaterialPageRoute<void>(
//                       //   builder: (BuildContext context) => Setup3Screen(
//                       //     gender: gender,
//                       //     interests: widget.interests,
//                       //     age: int.parse(agecontroller.text),
//                       //     light: widget.light,
//                       //     goal: widget.goal,
//                       //     name: namecontroller.text,
//                       //   ),
//                       // ));
//                     },
//                     style: TextButton.styleFrom(
//                         backgroundColor: AppConstants.critical,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35))),
//                     child: Text('Etape suivante',
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppConstants.white,
//                         ))),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
