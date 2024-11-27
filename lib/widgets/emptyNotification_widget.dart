import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_const.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 48,
        ),
        Image(image: AssetImage("assets/images/notification.png")),
        SizedBox(
          height: 27,
        ),
        Text(
          textAlign: TextAlign.center,
          'Pas de notifications'.toUpperCase(),
          style: GoogleFonts.teko(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppConstants.black,
            ),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          'Vous allez recevoir les notifications ici',
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppConstants.gray2,
            ),
          ),
        ),
      ],
    );
  }
}
