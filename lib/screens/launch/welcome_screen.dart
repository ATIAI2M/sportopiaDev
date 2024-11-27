import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/screens/launch/onBording_sceen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/welcome.png'),
                      fit: BoxFit.cover)),
            ),
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.transparent],
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Bienvenue à SPORTOPIA',
                    style: GoogleFonts.teko(
                        textStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.white)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Vous êtes passionné(e) de sport et vous recherchez un partenaire pour vous motiver et vous accompagner dans vos entraînements ? SPORTOPIA est là pour vous aider !',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          color: AppConstants.gray1),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1000),
                          color: AppConstants.critical),
                      child: IconButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool("fRun", false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnBordingScreen()));
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                        ),
                        color: AppConstants.white,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )),
          ],
        ),
      ],
    ));
  }
}
