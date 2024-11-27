import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/chat.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/matching/peopleProfile_screen.dart';
import 'package:testapp/widgets/like_item.dart';
import 'package:testapp/widgets/messages_item.dart';
import 'package:testapp/widgets/people_item.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  List<Client> likedClients = [];

  Client? client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).getLikes();
  }

  void removeClient(Client cl) {
    if (likedClients.isNotEmpty) {
      likedClients.remove(cl);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    likedClients = Provider.of<DataProvider>(context).likedClients;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: AppConstants.gray2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconSize: 24,
                        color: AppConstants.black,
                      ),
                    ),
                    Text(
                      'demandes En attente'.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              //height: 50,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: likedClients.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PeopleProfileScreen(
                                      client: likedClients[index],
                                      isMatched: false,
                                    )));
                      },
                      child: LikeItem(
                        client: likedClients[index],
                        removeClient: removeClient,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
