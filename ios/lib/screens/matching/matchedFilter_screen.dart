import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_const.dart';
import '../../models/client.dart';
import 'peopleProfile_screen.dart';

class MatchedFilterScreen extends StatefulWidget {
  final Client client;
  const MatchedFilterScreen({super.key, required this.client});

  @override
  State<MatchedFilterScreen> createState() => _MatchedFilterScreenState();
}

class _MatchedFilterScreenState extends State<MatchedFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFBE1414),
                Color(0xFF621D1D),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container()),
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset(
                    'assets/images/MatchedContainer.png',
                  ).image)),
                  child: Center(
                    child: ClipOval(
                      child: Image.network(
                        AppConstants().serverUrl + widget.client.imgUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/profile.jpg",
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'vous matchez avec '.toUpperCase() +
                          widget.client.fullName.toUpperCase() +
                          "!",
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.white,
                        ),
                      ),
                    ),
                    Text(
                      'Motivez-vous à deux!',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                          color: AppConstants.white),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                PeopleProfileScreen(
                              client: widget.client,
                              isMatched: true,
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
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Text(
                                'Discuter',
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
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(63, 234, 52, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Center(
                              child: Text(
                                'Continuer',
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
