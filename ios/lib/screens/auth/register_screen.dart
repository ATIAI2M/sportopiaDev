import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_const.dart';
import '../../providers/data_provider.dart';
import '../../root_screen.dart';
import 'login_screen.dart';
import 'start_screen.dart';
import 'verify_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool valuefirst = false;
  bool isLoading = false;

  GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    UserCredential? userCredential;
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth != null) {
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    }

    // Once signed in, return the UserCredential
    return userCredential;
  }

  Future<Position?> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show a dialog asking the user to enable location services.
      _showLocationErrorDialog(
        context,
        'Les services de localisation sont désactivés. Veuillez les activer pour continuer à utiliser l\'application.',
      );
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Show a dialog asking the user to grant location permissions.
        _showLocationErrorDialog(
          context,
          'Les permissions de localisation sont refusées. Veuillez accorder l\'autorisation pour continuer à utiliser l\'application.',
        );
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Show a dialog explaining that permissions are permanently denied.
      _showLocationErrorDialog(
        context,
        'Les permissions de localisation sont refusées de façon permanente. Veuillez les activer dans les paramètres pour continuer à utiliser l\'application.',
      );
      return null;
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _showLocationErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Localisation requise')),
          content: Text(message),
          actions: [
            Center(
              child: ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }  bool isShowed = true;
    bool isConfirmShowed = true;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            //height: MediaQuery.of(context).size.height * 0.98,
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenue sur SPORTOPIA',
                  style: GoogleFonts.teko(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.black,
                    ),
                  ),
                ),
                Text(
                  'Inscrivez-vous pour nous rejoindre',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                    color: AppConstants.gray1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final userCredential = await signInWithGoogle();
                                if (userCredential != null) {
                                  final isCorrect =
                                      await Provider.of<DataProvider>(context,
                                              listen: false)
                                          .socialLogin(
                                              userCredential.user!.email!,
                                              userCredential.user!.uid);
                                  if (isCorrect) {
                                    final client = Provider.of<DataProvider>(
                                            context,
                                            listen: false)
                                        .client;
                                    if (client != null) {
                                      final position =
                                          await _determinePosition(context);
                                      if (position != null) {
                                        var point = {
                                          "type": 'Point',
                                          "coordinates": [
                                            position.longitude,
                                            position.latitude
                                          ]
                                        };
                                        await Provider.of<DataProvider>(context,
                                                listen: false)
                                            .updatePosition(point);
                                        await _googleSignIn.disconnect();
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              RootScreen(),
                                        ));
                                      }
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            StartScreen(),
                                      ));
                                    }
                                  }
                                }

                                setState(() {
                                  isLoading = false;
                                });
                              },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                                side: BorderSide(
                                  color: AppConstants.line,
                                ))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 10),
                              Text('Continuer avec Google',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.black2,
                                  ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Divider(
                              height: 1,
                              thickness: 2,
                              color: Color(0xFFD9D9D9),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: Text(
                            'Ou bien',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppConstants.gray1,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: Divider(
                              height: 1,
                              thickness: 2,
                              color: Color(0xFFD9D9D9),
                            )),
                      ],
                    ),

                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height * 0.07,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     /* Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);
                    //            Navigator.of(context).pushReplacement(
                    //              MaterialPageRoute<void>(
                    //                builder: (BuildContext context) =>
                    //                    const LoginScreen(),*/

                    //     style: TextButton.styleFrom(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(35),
                    //             side: BorderSide(
                    //               color: AppConstants.line,
                    //             ))),
                    //     child: Padding(
                    //       padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Image.asset(
                    //             'assets/images/apple.png',
                    //             width: 24,
                    //             height: 24,
                    //           ),
                    //           SizedBox(width: 10),
                    //           Text('Continuer avec Apple',
                    //               style: GoogleFonts.poppins(
                    //                   textStyle: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600,
                    //                 color: AppConstants.black2,
                    //               ))),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 370,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Adresse e-mail',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                       TextFormField(
                        obscureText: isShowed,
                        controller: passwordcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mot de passe',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isShowed = !isShowed;
                                  });
                                },
                                icon: Icon(isShowed
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: isConfirmShowed,
                        controller: confirmpasswordcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: AppConstants.gray1,
                        ),
                        decoration:  InputDecoration(
                          border: const UnderlineInputBorder(),
                          labelText: 'Confirmer le mot de passe',
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              isConfirmShowed = !isConfirmShowed;
                            });
                          }, icon: Icon(isConfirmShowed ? Icons.visibility_outlined : Icons.visibility_off_outlined)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: valuefirst,
                      onChanged: (newValue) {
                        setState(() {
                          valuefirst = newValue ?? false;
                        });
                      },
                    ),
                    Text(
                      'J’accepte les termes et conditions',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppConstants.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: !valuefirst
                          ? null
                          : () async {
                              if (emailcontroller.text.isNotEmpty &&
                                  (passwordcontroller.text ==
                                      confirmpasswordcontroller.text) &&
                                  !isLoading) {
                                setState(() {
                                  isLoading = true;
                                });
                                await Provider.of<DataProvider>(context,
                                        listen: false)
                                    .createUser(emailcontroller.text,
                                        passwordcontroller.text);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("email", emailcontroller.text);
                                prefs.setString(
                                    "password", passwordcontroller.text);
                                prefs.setString("login_mode", "normal");
                                final otp = Random()
                                    .nextInt(9999)
                                    .toString()
                                    .padLeft(4, '0');
                                await Provider.of<DataProvider>(context,
                                        listen: false)
                                    .createOTP(otp);
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      VerifyScreen(
                                    fromRegister: true,
                                    otp: otp,
                                  ),
                                ));
                              }
                            },
                      style: TextButton.styleFrom(
                          backgroundColor: AppConstants.critical,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35))),
                      child: isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text('S’enregistrer',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.white,
                              ))),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vous avez un compte?',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.gray1,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        ' Se connecter',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
