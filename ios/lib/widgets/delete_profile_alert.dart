import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/data_provider.dart';
import '../screens/launch/onBording_sceen.dart';

import '../app_const.dart';

class DeleteProfileAlert extends StatefulWidget {
  const DeleteProfileAlert({super.key});

  @override
  State<DeleteProfileAlert> createState() => _DeleteProfileAlertState();
}

class _DeleteProfileAlertState extends State<DeleteProfileAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0), bottom: Radius.circular(40.0)),
      ),
      title: Text(
        textAlign: TextAlign.center,
        'Êtes-vous sûr de vouloir supprimer votre profil?',
        style: GoogleFonts.teko(
          textStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppConstants.black,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'La suppression de votre profil est irréversible, et vous perdrez l’accès à votre compte et à toutes les données associées. Si vous êtes certain de cette décision, veuillez le confirmer ci-dessous.',
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
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: TextButton(
                  onPressed: () async {
                    await Provider.of<DataProvider>(context, listen: false)
                        .deleteAccount();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.remove("login_mode");
                    await prefs.remove("email");
                    await prefs.remove("password");
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnBordingScreen()));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppConstants.critical,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 5, 70, 5),
                    child: Text(
                      'Confirmer',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(70, 5, 70, 5),
                    child: Text(
                      'Annuler',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF007AFF),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
