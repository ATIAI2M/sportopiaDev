import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app_const.dart';
import '../../functions/showsnack.dart';
import '../../models/client.dart';
import '../../providers/data_provider.dart';
import '../matching/peopleProfile_screen.dart';
import 'settings_screen.dart';
import '../../widgets/empty_state_widget.dart';
import '../../widgets/like_item.dart';
import '../../widgets/profile_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Client? client;
  List<Client> matchedClients = [];
  Map<Client, double> sortedClients = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).getMatchings();
    Provider.of<DataProvider>(context, listen: false).getLikes();
  }

  List<Client> likedClients = [];

  void removeClient(Client cl) {
    if (likedClients.isNotEmpty) {
      Provider.of<DataProvider>(context, listen: false)
          .deleteLike(cl.id)
          .then((value) {
        likedClients.remove(cl);
      }).catchError((err) {});
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    matchedClients =
        Provider.of<DataProvider>(context, listen: false).matchedClients;
    likedClients =
        Provider.of<DataProvider>(context, listen: true).likedClients;
    client = Provider.of<DataProvider>(context).client;

    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 48,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settingscreen()));
                        },
                        child: ClipOval(
                          child: Image.network(
                            AppConstants().serverUrl + client!.imgUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/profile.jpg",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: AutoSizeText(
                              'Bienvenue, '.toUpperCase() +
                                  client!.fullName.toUpperCase(),
                              style: GoogleFonts.teko(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.black,
                                ),
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Text(
                            client!.level,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              color: AppConstants.gray1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                matchedClients.isEmpty
                    ? EmptyHomeStateWidget()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            'Derniers matchs'.toUpperCase(),
                            style: GoogleFonts.teko(
                              color: AppConstants.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              height: 0.06,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: matchedClients.length,
                              itemBuilder: (context, int index) {
                                // final client =
                                //     sortedClients.keys.toList()[index];
                                // final distance =
                                //     sortedClients.values.toList()[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: ProfileItem(
                                      client: matchedClients[index],
                                      isMatched: true,
                                      //distance: 0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'En attente'.toUpperCase(),
                                style: GoogleFonts.teko(
                                  color: AppConstants.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  height: 0.06,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            // height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: likedClients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PeopleProfileScreen(
                                                    client: likedClients[index],
                                                    isMatched: false,
                                                  )));
                                    },
                                    child: LikeItem(
                                      click: (cl) {
                                        likedClients.remove(cl);
                                      },
                                      client: likedClients[index],
                                      removeClient: removeClient,
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
