import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app_const.dart';
import '../../models/client.dart';
import '../../providers/data_provider.dart';
import 'filterPeople_screen.dart';
import '../matching/likes_screen.dart';
import '../matching/peopleProfile_screen.dart';
import '../../widgets/pep_item.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  List<MapEntry<Client, double>> randomizedClients = [];
  bool isFetching = true;
  bool noMoreResults = false;
  bool isAll = false;

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  void randomizeClients(Map<Client, double> clients) {
    final random = Random();

    // Separate clients into two groups: nearby and distant
    final nearbyClients =
        clients.entries.where((entry) => entry.value <= 500).toList();
    final distantClients =
        clients.entries.where((entry) => entry.value > 500).toList();

    nearbyClients.shuffle(random);

    distantClients.sort((a, b) => a.value.compareTo(b.value));

    final combinedClients = nearbyClients + distantClients;

    setState(() {
      randomizedClients = combinedClients;
    });

    if (randomizedClients.isEmpty) {
      setState(() {
        noMoreResults = true;
      });
    }
  }

  void removeClientAndRefresh(Client client) {
    setState(() {
      randomizedClients.removeWhere((entry) => entry.key.id == client.id);
    });

    if (randomizedClients.isEmpty) {
      if (isAll) {
        setState(() {
          noMoreResults = true;
        });
      } else {
        loadClients(all: true);
        setState(() {
          isAll = true;
        });
      }
    }
  }

  Future<void> loadClients({bool all = false}) async {
    setState(() {
      isFetching = true;
      noMoreResults = false;
    });

    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    await dataProvider.getClients(all: all);

    final sortedClients = dataProvider.sortedClients;
    if (sortedClients.isEmpty && !all) {
      await loadClients(all: true);
    } else if (sortedClients.isEmpty) {
      setState(() {
        noMoreResults = true;
      });
    } else {
      randomizeClients(sortedClients);
    }

    setState(() {
      isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final likes =
        Provider.of<DataProvider>(context, listen: false).likedClients;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(likes),
            const SizedBox(height: 10),
            if (isFetching)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (isAll == true && noMoreResults)
              _buildNoMoreResults()
            else
              Expanded(
                child: PageView.builder(
                  itemCount: randomizedClients.length,
                  controller:
                      PageController(viewportFraction: 1), // Full-screen swipe
                  itemBuilder: (context, index) {
                    final entry = randomizedClients[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PeopleProfileScreen(
                              client: entry.key,
                              isMatched: false,
                            ),
                          ),
                        );
                      },
                      child: PepItem(
                        key: ValueKey(entry.key.id),
                        client: entry.key,
                        distance: entry.value,
                        removeClient: (client) {
                          removeClientAndRefresh(client);
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(List<Client> likes) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Trouvez votre partenaire'.toUpperCase(),
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
                      decoration: const BoxDecoration(
                        color: Color(0xFF3287FF),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/Add.svg',
                          color: const Color(0xFFFFFFFF),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LikesScreen()),
                          );
                        },
                      ),
                    ),
                  ),
                  if (likes.isNotEmpty)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            likes.length > 9 ? "9+" : likes.length.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: AppConstants.line,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/filter.svg',
                    color: const Color(0xFF848484),
                  ),
                  onPressed: () async {
                    final isUpdated = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const FilterPeopleScreen()),
                    );
                    if (isUpdated != null && isUpdated) {
                      loadClients();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoMoreResults() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/loading_img.png',
              height: 250,
              width: 250,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Text(
                  'À la recherche de votre partenaire idéal'.toUpperCase(),
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
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  color: AppConstants.gray1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 32, 28, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextButton(
                onPressed: () async {
                  final isUpdated = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const FilterPeopleScreen()),
                  );
                  if (isUpdated != null && isUpdated) {
                    loadClients();
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppConstants.critical,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
                child: Text(
                  'Mettre à jour les filtres',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
