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
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';
import '../auth/start_screen.dart';

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    UserCredential? userCredential;

    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // Once signed in, return the UserCredential
    return userCredential;
  }

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
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 0.97,
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bienvenue sur SPORTOPIA',
                style: GoogleFonts.teko(
                    textStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.black)),
              ),
              Text(
                textAlign: TextAlign.center,
                'Connectez-vous et commencez à chercher votre partenaire sportif idéal !',
                style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    color: AppConstants.gray1),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    //Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: AppConstants.critical,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35))),
                  child: Text('Se connecter',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.white,
                      ))),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    //Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context) => const RegisterScreen(),
                    ));
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                          side: BorderSide(
                            color: AppConstants.line,
                          ))),
                  child: Text('Inscrivez vous',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.gray1,
                      ))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Divider(
                        height: 1,
                        thickness: 1.5,
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
                        thickness: 1.5,
                        color: Color(0xFFD9D9D9),
                      )),
                ],
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
                              if (isLoading) {
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
                                      if (client.status == "banned") {
                                        showSnackBar(
                                            "Votre compte a été suspendu");
                                      } else if (client.status == "deleted") {
                                        showSnackBar(
                                            "Votre compte a été supprimé");
                                      } else {
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
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString("email",
                                              userCredential.user!.email!);
                                          prefs.setString("password",
                                              userCredential.user!.uid);
                                          prefs.setString(
                                              "login_mode", "social");
                                          await Provider.of<DataProvider>(
                                                  context,
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
                  SignInWithAppleButton(
                      onPressed: isLoading
                          ? () {}
                          : () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (isLoading) {
                                final userCredential = await signInWithApple();
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
                                      if (client.status == "banned") {
                                        showSnackBar(
                                            "Votre compte a été suspendu");
                                      } else if (client.status == "deleted") {
                                        showSnackBar(
                                            "Votre compte a été supprimé");
                                      } else {
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
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString("email",
                                              userCredential.user!.email!);
                                          prefs.setString("password",
                                              userCredential.user!.uid);
                                          prefs.setString(
                                              "login_mode", "social");
                                          await Provider.of<DataProvider>(
                                                  context,
                                                  listen: false)
                                              .updatePosition(point);

                                          await FirebaseAuth.instance.signOut();
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                RootScreen(),
                                          ));
                                        }
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
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.height * 0.07,
                  //   child: TextButton(
                  //     onPressed: isLoading
                  //         ? null
                  //         : () async {
                  //             setState(() {
                  //               isLoading = true;
                  //             });
                  //             if (isLoading) {
                  //               final userCredential = await signInWithApple();
                  //               if (userCredential != null) {
                  //                 final isCorrect =
                  //                     await Provider.of<DataProvider>(context,
                  //                             listen: false)
                  //                         .socialLogin(
                  //                             userCredential.user!.email!,
                  //                             userCredential.user!.uid);
                  //                 if (isCorrect) {
                  //                   final client = Provider.of<DataProvider>(
                  //                           context,
                  //                           listen: false)
                  //                       .client;
                  //                   if (client != null) {
                  //                     final position =
                  //                         await _determinePosition();
                  //                     if (position != null) {
                  //                       var point = {
                  //                         "type": 'Point',
                  //                         "coordinates": [
                  //                           position.longitude,
                  //                           position.latitude
                  //                         ]
                  //                       };
                  //                       SharedPreferences prefs =
                  //                           await SharedPreferences
                  //                               .getInstance();
                  //                       prefs.setString("email",
                  //                           userCredential.user!.email!);
                  //                       prefs.setString("password",
                  //                           userCredential.user!.uid);
                  //                       prefs.setString("login_mode", "social");
                  //                       await Provider.of<DataProvider>(context,
                  //                               listen: false)
                  //                           .updatePosition(point);
                  //                       await _googleSignIn.disconnect();
                  //                       await FirebaseAuth.instance.signOut();
                  //                       Navigator.of(context).pushReplacement(
                  //                           MaterialPageRoute<void>(
                  //                         builder: (BuildContext context) =>
                  //                             RootScreen(),
                  //                       ));
                  //                     }
                  //                   } else {
                  //                     Navigator.of(context).pushReplacement(
                  //                         MaterialPageRoute<void>(
                  //                       builder: (BuildContext context) =>
                  //                           StartScreen(),
                  //                     ));
                  //                   }
                  //                 }
                  //               }
                  //             }

                  //             setState(() {
                  //               isLoading = false;
                  //             });
                  //           },
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
            ],
          ),
        ),
      ),
    );
  }
}
