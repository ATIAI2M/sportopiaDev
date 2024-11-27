import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/matching/matchedFilter_screen.dart';

class LikeItem extends StatelessWidget {
  final Client client;
  final Function removeClient;
  const LikeItem({super.key, required this.client, required this.removeClient});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: Image.network(
          AppConstants().serverUrl + client.imgUrl,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "assets/images/profile.jpg",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      title: Row(
        children: [
          Text(
            client.fullName,
            style: GoogleFonts.teko(
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          const Icon(
            Icons.verified,
            size: 15,
            color: Color(0xFF3897F0),
          )
        ],
      ),
      // subtitle: Text(
      //   "Matched on 23 December",
      //   style: GoogleFonts.poppins(
      //     textStyle: const TextStyle(
      //       fontSize: 10,
      //       fontWeight: FontWeight.w400,
      //       color: Colors.grey,
      //     ),
      //   ),
      // ),
      trailing: SizedBox(
        width: 120,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                removeClient(client);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 251, 236, 236),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: AppConstants.critical,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(253, 71, 85, 0.43),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/heart.svg',
                  color: const Color(0xFFFD4755),
                ),
                onPressed: () async {
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
                    removeClient(client);
                    final matched =
                        await Provider.of<DataProvider>(context, listen: false)
                            .like(client.id);

                    if (matched != null) {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) => MatchedFilterScreen(
                          client: client,
                        ),
                      ));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
