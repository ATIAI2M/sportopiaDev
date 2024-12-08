import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/matching/matchedFilter_screen.dart';
import 'package:testapp/widgets/RotateDismissible.dart';

class PepItem extends StatefulWidget {
  final Client client;
  final double distance;
  final Function removeClient;

  const PepItem({
    super.key,
    required this.client,
    required this.distance,
    required this.removeClient,
  });

  @override
  State<PepItem> createState() => _PepItemState();
}

class _PepItemState extends State<PepItem> {
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // var sports =["Tennis" , "Football" , "Basketball" , "Handball" , "Volleyball" , "Hand"];
    var sports = widget.client.sports.keys.toList();

    return RotatingDismissible(
      key: Key(widget.client.id),
      onDismissed: (direction) async {
        // Remove the client immediately to avoid the error

        // Handle swipe directions
        if (direction == DismissDirection.endToStart) {
          //if user in like page unlike him
          if (Provider.of<DataProvider>(context, listen: false)
                  .likedClients
                  .indexWhere((element) => element.id == widget.client.id) !=
              -1) {
            await Provider.of<DataProvider>(context, listen: false)
                .deleteLike(widget.client.id);
          }
          widget.removeClient(widget.client);
        } else if (direction == DismissDirection.startToEnd) {
          // Right swipe: Handle like action
          final likesCount =
              await Provider.of<DataProvider>(context, listen: false)
                  .getLikesToday();
          if (likesCount >= AppConstants().likesLimit) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Limite de likes')),
                  content: const Text(
                      "Vous avez atteint la limite de likes par jour"),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            // Perform the like action
            await Provider.of<DataProvider>(context, listen: false)
                .like(widget.client.id)
                .then((v) {
              if (v != null) {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) => MatchedFilterScreen(
                    client: widget.client,
                  ),
                ));
              }
              widget.removeClient(widget.client);
            });
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        AppConstants().serverUrl + widget.client.imgUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width * 0.9,
                        height: size.height * 0.6,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black38,
                              Colors.black87
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.client.fullName,
                                style: GoogleFonts.teko(
                                  textStyle: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${widget.client.age} Ans",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: AppConstants.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '- À ${widget.distance.toStringAsFixed(0)} Km',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      color: AppConstants.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: sports.map((sport) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color:
                                            Color(0xFFFFFFFF).withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0.0, sigmaY: 0.0),
                                      child: Text(
                                        sport,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                  Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: size.width * 0.4,
                                    padding: const EdgeInsets.all(8),
                                 
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            widget.removeClient(widget.client);
                                          },
                                          child: Container(
                                            width: 55,
                                            height: 55,
                                            decoration:  BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 251, 236, 236),
                                              shape: BoxShape.circle,
                                              boxShadow:  [
                                        BoxShadow(
                                          color: AppConstants.gray1.withOpacity(
                                              0.2), // Shadow color with transparency
                                          spreadRadius: 4, // Spread radius
                                          blurRadius: 40, // Blur radius
                                          offset: Offset(8,
                                              0), // Offset in X and Y directions
                                        ),
                                      ],
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              size: 35,
                                              color: AppConstants.critical,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration:  BoxDecoration(
                                            color:
                                                Color.fromRGBO(253, 71, 85, 1),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppConstants.critical
                                                    .withOpacity(0.2),
                                                spreadRadius: 0,
                                                blurRadius: 40,
                                                offset: const Offset(8, 0),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              'assets/images/heart.svg',
                                              width: 35,
                                              height: 35,
                                              color: Colors.white,
                                            ),
                                            onPressed: () async {
                                              if (!isProcessing) {
                                                setState(() {
                                                  isProcessing = true;
                                                });
                                                await _handleMatch(context);
                                                widget.removeClient(
                                                    widget.client);

                                                setState(() {
                                                  isProcessing = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _handleMatch(BuildContext context) async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    final likesCount = await dataProvider.getLikesToday();
    if (!mounted) return;

    if (likesCount >= AppConstants().likesLimit) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text('Limite de likes')),
            content:
                const Text("Vous avez atteint la limite de likes par jour"),
            actions: [
              Center(
                child: ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    } else {
      final matched = await dataProvider.like(widget.client.id);
      if (!mounted) return;

      if (matched != null) {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => MatchedFilterScreen(
            client: widget.client,
          ),
        ));
      }
    }
  }
}
