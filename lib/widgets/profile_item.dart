import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/screens/old/coachProfile_screen.dart';
import 'package:testapp/screens/matching/peopleProfile_screen.dart';
import 'package:testapp/screens/profile/editProfile_screen.dart';
import 'package:testapp/screens/old/findpeopleProfile_screen.dart';
import 'package:testapp/screens/home/settings_screen.dart';

class ProfileItem extends StatelessWidget {
  final Client client;
  final bool isMatched;
  const ProfileItem({
    super.key,
    required this.client,
    required this.isMatched, // required this.distance
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PeopleProfileScreen(
                      client: client,
                      isMatched: isMatched,
                    )));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  AppConstants().serverUrl + client.imgUrl,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/profile.jpg",
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      client.fullName.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.verified,
                      color: Color(0xFF3897F0),
                      size: 15,
                    )
                  ],
                ),
                Text(
                  client.sports.keys.first,
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                      color: Color(0xFF9DB2CE)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
