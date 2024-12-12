import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app_const.dart';
import '../../models/client.dart';
import '../../providers/data_provider.dart';
import '../../root_screen.dart';
import '../chat/messages_screen.dart';
import 'rate_client_screen.dart';
import '../../widgets/report_widget.dart';

class PeopleProfileScreen extends StatefulWidget {
  final Client client;
  final bool isMatched;
  const   PeopleProfileScreen(
      {super.key, required this.client, required this.isMatched});

  @override
  State<PeopleProfileScreen> createState() => _PeopleProfileScreenState();
}

class _PeopleProfileScreenState extends State<PeopleProfileScreen> {
  Widget sportWidget() {
    return Column(
      children: [
        ...widget.client.sports.keys.map((e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                e,
                style: GoogleFonts.poppins(
                  color: AppConstants.gray1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        border: Border.all(
                          color: Color.fromRGBO(145, 158, 171, 0.32),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.client.sports[e]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: AppConstants.gray1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF1E1E1E),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
                      child: Row(
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppConstants.line,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_new),
                              onPressed: () {
                                /*
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const StartScreen(),
                                ));*/
                                Navigator.of(context).pop();
                              },
                              iconSize: 24,
                              color: AppConstants.line,
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: AppConstants.line,
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: AppConstants.line,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(13.0)),
                                  ),
                                  backgroundColor:
                                      Color.fromRGBO(24, 24, 24, 1),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: const BoxDecoration(),
                                      height: 220,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 12, 16, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.min,

                                          children: <Widget>[
                                            Text("Explorer les options",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppConstants.gray1,
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                "Sélectionnez une action à poursuivre",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppConstants.gray1,
                                                  ),
                                                )),
                                            Divider(
                                              color: AppConstants.gray1,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                showModalBottomSheet<void>(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    13.0)),
                                                  ),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ReportWidget(
                                                      client: widget.client,
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                  "Signaler l’utilisateur",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                           FontWeight.w400,
                                                      color: Color(0xFF0A84FF),
                                                    ),
                                                  )),
                                            ),
                                         widget.isMatched ?    TextButton(
                                              onPressed: () async {
                                                final client =
                                                    Provider.of<DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .client;
                                                await Provider.of<DataProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteMatch(client!.id,
                                                        widget.client.id);
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Annuler le match",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )),
                                            ) : Container() , 
                                            widget.isMatched ?  TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.of(context).push(
                                                    MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          RateClientScreen(
                                                    client: widget.client,
                                                  ),
                                                ));
                                              },
                                              child: Text(
                                                  "Evaluer ce partenaire",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      color: Color(0xFF0A84FF),
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  )),
                                            ):Container(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              iconSize: 24,
                              color: AppConstants.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipOval(
                          child: Image.network(
                            AppConstants().serverUrl + widget.client.imgUrl,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/profile.jpg",
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.client.fullName.toUpperCase(),
                            style: GoogleFonts.teko(
                              textStyle: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.line,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                         
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: Colors.grey,
                            size: 40,
                          ),
                          SizedBox(width: 10),
                          Text(
                            widget.client.rate.toStringAsFixed(1),
                            style: GoogleFonts.teko(
                              textStyle: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.critical,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            widget.client.gender,
                            style: GoogleFonts.teko(
                              color: AppConstants.gray1,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 0.06,
                            ),
                          ),
                          Text(
                            widget.client.height.toStringAsFixed(0) + ' CM',
                            style: GoogleFonts.teko(
                              color: AppConstants.gray1,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 0.06,
                            ),
                          ),
                          Text(
                            widget.client.weight.toStringAsFixed(0) + ' KG',
                            style: GoogleFonts.teko(
                              color: AppConstants.gray1,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 0.06,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      Text(
                        'A Propos'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.client.bio,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Addresse'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.client.city +
                            ", " +
                            widget.client.region +
                            ", " +
                            widget.client.country,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Sports Pratiqués/Préférés'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      sportWidget(),
                      // Wrap(
                      //   children: [
                      //     ...widget.client.sports.keys.map((e) => Padding(
                      //           padding: const EdgeInsets.only(right: 5),
                      //           child: Chip(
                      //             backgroundColor: Color(0xFF1E1E1E),
                      //             label: Text(
                      //               e,
                      //               style: GoogleFonts.poppins(
                      //                 color: AppConstants.gray1,
                      //               ),
                      //             ),
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(50),
                      //               side: BorderSide(
                      //                 width: 1,
                      //                 color:
                      //                     Color.fromRGBO(145, 158, 171, 0.32),
                      //               ),
                      //             ),
                      //           ),
                      //         ))
                      //   ],
                      // ),
                      SizedBox(height: 35),
                      Text(
                        'Objectif Principal'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        children: [
                          ...widget.client.goal.map((e) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(
                                  backgroundColor: Color(0xFF1E1E1E),
                                  label: Text(
                                    e,
                                    style: GoogleFonts.poppins(
                                      color: AppConstants.gray1,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(145, 158, 171, 0.32),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Fréquence d\'entraînement'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.client.frequency,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Équipement'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        children: [
                          ...widget.client.items.map((e) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(
                                  backgroundColor: Color(0xFF1E1E1E),
                                  label: Text(
                                    e,
                                    style: GoogleFonts.poppins(
                                      color: AppConstants.gray1,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(145, 158, 171, 0.32),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Langues Parlées'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Wrap(
                        children: [
                          ...widget.client.language.map((e) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(
                                  backgroundColor: Color(0xFF1E1E1E),
                                  label: Text(
                                    e,
                                    style: GoogleFonts.poppins(
                                      color: AppConstants.gray1,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(145, 158, 171, 0.32),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 35),
                      Text(
                        'Marche avec des animaux'.toUpperCase(),
                        style: GoogleFonts.teko(
                          color: AppConstants.gray1,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          height: 0.06,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.client.animal,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 35),
                      if (widget.isMatched)
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () async {
                              await Provider.of<DataProvider>(context,
                                      listen: false)
                                  .getChats();
                              final chats = Provider.of<DataProvider>(context,
                                      listen: false)
                                  .chats;

                              final chat = chats.firstWhere((element) =>
                                  element.receiverId == widget.client.id ||
                                  element.senderId == widget.client.id);
                              Navigator.of(context)
                                  .push(MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    MessagesScreen(
                                  chat: chat,
                                  client: widget.client,
                                ),
                              ));
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppConstants.critical,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(100, 8, 100, 8),
                              child: Text(
                                'Envoyer message',
                                style: GoogleFonts.teko(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
