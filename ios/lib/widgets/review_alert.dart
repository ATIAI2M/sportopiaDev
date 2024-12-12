import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_const.dart';

class ReviewAlert extends StatelessWidget {
  const ReviewAlert({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0), bottom: Radius.circular(40.0)),
      ),
      title: Align(
        alignment: Alignment.topCenter,
        child: Text(
          'Merci beaucoup!',
          style: GoogleFonts.teko(
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppConstants.black,
            ),
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'Nous avons reçu vos commentaires, nos idées sont inestimables pour nous alors que nous nous efforçons d’améliorer notre communauté et d’offrir la meilleure expérience pour tout le monde.',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppConstants.black,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).push(MaterialPageRoute<void>(
                //   builder: (BuildContext context) =>
                //       const FindCoachesEmpty(),
                // ));
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFFF2F2F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 5, 70, 5),
                child: Text(
                  'Ok',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
