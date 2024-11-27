// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/screens/filterCoaches_screen.dart';
// import 'package:testapp/screens/findCoachesEmpty_screen.dart';
// import 'package:testapp/widgets/profile_item.dart';

// import '../models/client.dart';
// import '../providers/data_provider.dart';

// class FindCoachesScreen extends StatefulWidget {
//   const FindCoachesScreen({super.key});

//   @override
//   State<FindCoachesScreen> createState() => _FindCoachesScreenState();
// }

// class _FindCoachesScreenState extends State<FindCoachesScreen> {
//   List<Client> clients = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // clients = Provider.of<DataProvider>(context).getClients();

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(28, 51.5, 28, 0),
//             child: Column(
//               children: [
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // Navigator.of(context).push(MaterialPageRoute<void>(
//                           //   builder: (BuildContext context) => const Settingscreen(),
//                           // ));
//                         },
//                         child: ClipOval(
//                           child: Image.asset('assets/images/profile.jpg',
//                               width: 60, height: 60, fit: BoxFit.cover),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Welcome, Omar',
//                             style: GoogleFonts.teko(
//                               textStyle: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppConstants.black,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             'Beginner',
//                             style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     fontSize: 12, fontWeight: FontWeight.w400),
//                                 color: AppConstants.gray1),
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: Container(
//                           width: double.infinity,
//                           alignment: Alignment.topRight,
//                           child: Container(
//                             width: 45,
//                             height: 45,
//                             decoration: BoxDecoration(
//                               color: AppConstants.line,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.notifications,
//                               size: 24,
//                               color: Color(0xFF848484),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]),
//                 SizedBox(
//                   height: 32,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: TextField(
//                       keyboardType: TextInputType.text,
//                       autofocus: false,
//                       style: TextStyle(
//                         color: AppConstants.gray1,
//                       ),
//                       decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide:
//                               BorderSide(width: 1, color: Color(0xFFEDEDED)),
//                           borderRadius: BorderRadius.circular(45.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: AppConstants.gray1,
//                           ),
//                           borderRadius: BorderRadius.circular(45.0),
//                         ),
//                         labelStyle: TextStyle(color: Color(0xFFFB3B2B2)),
//                         filled: true,
//                         fillColor: Color(0xFFFBFBFB),
//                         contentPadding:
//                             EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(45.0),
//                         ),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: AppConstants.gray1,
//                         ),
//                         hintText: 'Search here ...',
//                         hintStyle: TextStyle(
//                             color: AppConstants.gray1,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppConstants.black,
//                           borderRadius: BorderRadius.circular(55)),
//                       child: IconButton(
//                         icon: Icon(
//                           Icons.tune,
//                           color: AppConstants.line,
//                         ),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pushReplacement(MaterialPageRoute<void>(
//                             builder: (BuildContext context) =>
//                                 const FilterCoaches(),
//                           ));
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 38,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'TOP COACHES ',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   height: 120,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: clients.length,
//                     itemBuilder: (context, int index) {
//                       return GestureDetector(
//                         onTap: () {},
//                         child: ProfileItem(
//                           client: clients[index],
//                           distance: 0,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(
//                   height: 48,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     'NEAR BY ',
//                     style: GoogleFonts.teko(
//                       color: AppConstants.gray1,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w600,
//                       height: 0.06,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.4,
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount:
//                             MediaQuery.of(context).size.width < 390 ? 2 : 3),
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         child: ProfileItem(
//                           client: clients[index],
//                           distance: 0,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
