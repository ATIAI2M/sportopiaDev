import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';

class PeopleItem extends StatelessWidget {
  final Client client;
  const PeopleItem({super.key, required this.client});

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
          SizedBox(
            width: 5,
          ),
          Icon(
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
      trailing: SvgPicture.asset(
        'assets/images/comment-text.svg',
      ),
    );
  }
}
