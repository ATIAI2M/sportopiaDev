import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/matching/matchedFilter_screen.dart';
import 'package:testapp/widgets/RotateDismissible.dart';

class PepItem extends StatelessWidget {
  final Client client;
  final double distance;
  final Function removeClient;
  const PepItem(
      {super.key,
      required this.client,
      required this.distance,
      required this.removeClient});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return RotatingDismissible(
      key: ValueKey(client.id),
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          print("Swiped left on card ");
          removeClient(client);
        } else if (direction == DismissDirection.startToEnd) {
          _handleMatch(context);
        }
        
        ;
      },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                    image:
                        NetworkImage(AppConstants().serverUrl + client.imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: size.width * 0.9,
                      height: size.height * 0.12,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              client.fullName,
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
                                  "${client.age.toString()} Ans",
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
                                  '- À ${distance.toStringAsFixed(0)} Km',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      color: AppConstants.white),
                                ),
                              ],
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        removeClient(client);
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 251, 236, 236),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 35,
                          color: AppConstants.critical,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(253, 71, 85, 0.43),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/heart.svg',
                            width: 35,
                            height: 35,
                            color: const Color(0xFFFD4755),
                          ),
                          onPressed: () {
                            _handleMatch(context);
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleMatch(BuildContext context) async {
    final likesCount =
        await Provider.of<DataProvider>(context, listen: false).getLikesToday();
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
      removeClient(client);
      final matched = await Provider.of<DataProvider>(context, listen: false)
          .like(client.id);

      if (matched != null) {
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => MatchedFilterScreen(
            client: client,
          ),
        ));
      }
    }
  }
}
