import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/screens/auth/start_screen.dart';

class VerifyScreen extends StatefulWidget {
  final bool fromRegister;
  final String otp;
  const VerifyScreen(
      {super.key, required this.fromRegister, required this.otp});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController codecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.97,
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "vérifier votre compte".toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.teko(
                  textStyle:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            ),
            Text(
                'Veuillez entrer le code OTP que vous avez reçu par e-mail pour vérifier votre compte.',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.gray1))),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: codecontroller,
              showCursor: false,
              maxLength: 4,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 96,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextButton(
                onPressed: () {
                  if (widget.fromRegister) {
                    if (codecontroller.text.toString() == widget.otp) {
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute<void>(
                        builder: (BuildContext context) => const StartScreen(),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "OTP incorrect!",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppConstants.critical,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45))),
                child: Text('Confirmer',
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
