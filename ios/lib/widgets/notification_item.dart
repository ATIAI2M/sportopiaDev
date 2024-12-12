import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_const.dart';
import '../models/client.dart';
import '../models/notification.dart';

class NotificationItem extends StatelessWidget {
  final Notif notif;
  const NotificationItem({super.key, required this.notif});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(notif.createdAt);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/images/bell.svg',
          width: 40,
          height: 40,
        ),
        title: Text(
          notif.title.toUpperCase(),
          style: GoogleFonts.teko(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        subtitle: Text(
          notif.body,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
        trailing: Text(
          date.toString().substring(0, 16),
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppConstants.black2,
            ),
          ),
        ),
      ),
    );
  }
}
