// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:testapp/app_const.dart';
// import 'package:testapp/models/client.dart';
// import 'package:testapp/providers/data_provider.dart';
// import 'package:testapp/widgets/pep_item.dart';

// class ListClientsScreen extends StatefulWidget {
//   const ListClientsScreen({super.key});

//   @override
//   State<ListClientsScreen> createState() => _ListClientsScreenState();
// }

// class _ListClientsScreenState extends State<ListClientsScreen> {
//   Map<Client, double> sortedClients = {};
//   Map<Client, double> limitedsortedClients = {};

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     Provider.of<DataProvider>(context, listen: false).getClients();
//   }

//   @override
//   Widget build(BuildContext context) {
//     sortedClients = Provider.of<DataProvider>(context).sortedClients;

//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
//               child: Row(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Trouver un compagnon'.toUpperCase(),
//                         style: GoogleFonts.teko(
//                           textStyle: const TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                             color: AppConstants.black,
//                           ),
//                         ),
//                       ),
//                       Text(
//                         'Profitez des activités ensemble',
//                         style: GoogleFonts.poppins(
//                             textStyle: TextStyle(
//                                 fontSize: 14, fontWeight: FontWeight.w400),
//                             color: AppConstants.gray1),
//                       ),
//                     ],
//                   ),
//                   Expanded(child: Container()),
//                   Container(
//                     decoration: BoxDecoration(
//                         color: AppConstants.line,
//                         borderRadius: BorderRadius.circular(55)),
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.tune,
//                         color: AppConstants.gray1,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Expanded(
//               // height: 200,
//               // width: double.infinity,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemCount: sortedClients.length,
//                 itemBuilder: (context, int index) {
//                   final client = sortedClients.keys.toList()[index];
//                   final distance = sortedClients.values.toList()[index];
//                   return GestureDetector(
//                     onTap: () {},
//                     child: PepItem(
//                       client: client,
//                       distance: distance,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//     /*
//     Scaffold(
//       body: Column(children: [PepItem(), PepItem()]),
//     );*/
//   }
// }
