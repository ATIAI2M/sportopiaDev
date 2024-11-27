import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/home/filterPeople_screen.dart';
import 'package:testapp/screens/matching/likes_screen.dart';
import 'package:testapp/screens/matching/peopleProfile_screen.dart';
import 'package:testapp/widgets/pep_item.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Map<Client, double> sortedClients = {};
  Map<Client, double> limitedSortedClients = {};

  int limit = 1;
  int startingIndex = 0;

  // Timer? _timer;

  // static const int _countdownDurationSeconds = 180;

  // static const int _countdownDurationMilliseconds =
  //     _countdownDurationSeconds * 1000;

  // int _secondsRemaining = _countdownDurationSeconds;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
    Provider.of<DataProvider>(context, listen: false).getLikes();
    if (limitedSortedClients.isNotEmpty) {
      //startCountdown();
    }
  }

  // Method to start the countdown timer
  // void startCountdown() {
  //   if (_timer != null) {
  //     if (_timer!.isActive) {
  //       _timer!.cancel();
  //     }
  //   }

  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_secondsRemaining > 0) {
  //         _secondsRemaining--;
  //       } else {
  //         // Reset timer when it finishes
  //         _secondsRemaining = _countdownDurationSeconds;
  //         // Remove all clients from limitedSortedClients
  //         limitedSortedClients.clear();
  //         // Load the next 3 clients
  //         limitClients();
  //       }
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel(); // Cancel the timer to prevent memory leaks
  //   super.dispose();
  // }

  void limitClients() {
    limitedSortedClients.clear();

    int remainingClients = sortedClients.length - startingIndex;
    int endingIndex =
        startingIndex + (remainingClients < limit ? remainingClients : limit);

    List<MapEntry<Client, double>> clientsSlice =
        sortedClients.entries.toList().sublist(startingIndex, endingIndex);

    for (var entry in clientsSlice) {
      limitedSortedClients[entry.key] = entry.value;
    }
    if (limitedSortedClients.isNotEmpty) {
      // _secondsRemaining = _countdownDurationSeconds;
      // startCountdown();
    }
    startingIndex = endingIndex;
  }

  void removeClientAndFillIfNeeded(Client cl) {
    if (limitedSortedClients.isNotEmpty) {
      limitedSortedClients.remove(cl);
    }
    if (limitedSortedClients.isEmpty) {
      limitClients();
    }
    setState(() {});
  }

  Future<void> load() async {
    await Provider.of<DataProvider>(context, listen: false).getClients();
    limitClients();
  }

  @override
  Widget build(BuildContext context) {
    sortedClients = Provider.of<DataProvider>(context).sortedClients;
    final likes = Provider.of<DataProvider>(context).likedClients;

    return SafeArea(
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'trouvez votre partenaire'
                        .toUpperCase(),
                    style: GoogleFonts.teko(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.black,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF3287FF),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/Add.svg',
                                  color: Color(0xFFFFFFFF),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LikesScreen()));
                                },
                                // Icons.tune,
                                // size: 24,
                                // color: Color(0xFF848484),
                              ),
                            ),
                          ),
                          if (likes.isNotEmpty)
                            Positioned(
                                right: 0,
                                top: 0,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Center(
                                    child: Text(
                                      likes.length > 9
                                          ? "9+"
                                          : likes.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 8),
                                    ),
                                  ),
                                ))
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppConstants.line,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/filter.svg',
                            color: Color(0xFF848484),
                          ),
                          onPressed: () async {
                            final isUpdated = await Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FilterPeopleScreen(),
                            ));
                            print(isUpdated);
                            if (isUpdated) {
                              startingIndex = 0;
                              limitClients();
                              setState(() {});
                            }
                          },
                          // Icons.tune,
                          // size: 24,
                          // color: Color(0xFF848484),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //if (limitedSortedClients.isNotEmpty)
            // Center(
            //   child: Container(
            //     height: 45,
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     width: MediaQuery.of(context).size.width * 0.8,
            //     child: Center(
            //       child: Text(
            //         'Il vous reste ${_secondsRemaining ~/ 60}:${_secondsRemaining % 60} min pour matcher',
            //         style: TextStyle(fontSize: 16, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            limitedSortedClients.isEmpty
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Expanded(child: Container()),
                        ClipOval(
                          child: Image.asset(
                            'assets/images/loading_img.png',
                            height: 250,
                            width: 250,
                          ),
                        ),
                        // Expanded(child: Container()),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                'À la recherche de votre partenaire idéal'
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.teko(
                                  textStyle: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.black,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Envisagez de modifier les filtres',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  color: AppConstants.gray1),
                            ),
                          ],
                        ),
                        // Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: TextButton(
                              onPressed: () async {
                                final isUpdated = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const FilterPeopleScreen(),
                                ));
                                print(isUpdated);
                                if (isUpdated && isUpdated != null) {
                                  startingIndex = 0;
                                  limitClients();
                                  setState(() {});
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: AppConstants.critical,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                              child: Text(
                                'Mettre à jour les filtres',
                                style: GoogleFonts.poppins(
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
                        // Expanded(child: Container()),
                      ],
                    ),
                  )
                : Expanded(
                    // height: 200,
                    // width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: false,
                      scrollDirection: Axis.vertical,
                      itemCount: limitedSortedClients.length,
                      itemBuilder: (context, int index) {
                        final client =
                            limitedSortedClients.keys.toList()[index];
                        final distance =
                            limitedSortedClients.values.toList()[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PeopleProfileScreen(
                                          client: client,
                                          isMatched: false,
                                        )));
                          },
                          child: PepItem(
                            client: client,
                            distance: distance,
                            removeClient: removeClientAndFillIfNeeded,
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
