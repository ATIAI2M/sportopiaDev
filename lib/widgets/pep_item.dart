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
import 'package:testapp/main.dart';
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

    
    var sports = widget.client.sports.keys.toList();
    print(widget.client.id);
    return RotatingDismissible(
      key: ValueKey(widget.client.id),
 onDismissed: (direction) async {
  final dataProvider = Provider.of<DataProvider>(navigatorKey.currentState!.context, listen: false);

  widget.removeClient(widget.client);

  if (direction == DismissDirection.endToStart) {
    // Handle "dislike" or "unlike"
    if (dataProvider.likedClients.any((element) => element.id == widget.client.id)) {
      await dataProvider.deleteLike(widget.client.id);
    }
  } else if (direction == DismissDirection.startToEnd) {
    // Handle "like"
    final likesCount = await dataProvider.getLikesToday();
    final likeLimit = AppConstants().likesLimit * 10;

    if (likesCount >= likeLimit) {
      // Show dialog if like limit is reached
      _showLikeLimitDialog(navigatorKey.currentState!.context);
    } else {
      // Perform the like action
      final matchedClient = await dataProvider.like(widget.client.id);

      if (matchedClient != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MatchedFilterScreen(
              client: widget.client,
            ),
          ),
        );
      }
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
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: size.width * 0.4,
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.removeClient(widget.client);
                              },
                              child: Container(
                                width: 55,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 251, 236, 236),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppConstants.gray1.withOpacity(
                                          0.2), 
                                      spreadRadius: 4, 
                                      blurRadius: 40, 
                                      offset: Offset(
                                          8, 0), 
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
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(253, 71, 85, 1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppConstants.critical.withOpacity(0.2),
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
                                    widget.removeClient(widget.client);
                  
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
  
  void _showLikeLimitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Limite de likes')),
          content: const Text("Vous avez atteint la limite de likes par jour"),
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
  }
}

