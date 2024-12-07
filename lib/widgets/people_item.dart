import 'package:cached_network_image/cached_network_image.dart';
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
        child: CachedNetworkImage(
                            imageUrl: AppConstants().serverUrl + client!.imgUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
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
