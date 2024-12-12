import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_const.dart';
import 'complete_profile_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.97,
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/logogrey.png',
              width: 170,
              height: 100,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Créez votre profil et commencez votre recherche".toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.teko(
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            ),
            Text(
                'Plus vous nous en direz, plus nous pourrons vous trouver les partenaires qui vous correspondent le mieux',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.gray1))),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const CompleteProfileScreen(),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppConstants.critical,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45))),
                child: Text('Créer mon profil',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.white,
                    ))),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
