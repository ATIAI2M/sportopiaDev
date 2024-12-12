import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_const.dart';

class EmptyHomeStateWidget extends StatelessWidget {
  const EmptyHomeStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 48,
          ),
          Image(image: AssetImage("assets/images/empty-home.png")),
          SizedBox(
            height: 27,
          ),
          Text(
            textAlign: TextAlign.center,
            'Pas de match pour l’instant ?\nNe vous découragez pas !'
                .toUpperCase(),
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
            'Restez connecté(e) à la communauté de Sportopia  pour ne manquer aucune information sur les prochains matchs ! Et continuez à vivre votre passion sportive au quotidien.',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppConstants.gray2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
