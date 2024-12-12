import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_const.dart';
import '../../providers/data_provider.dart';
import '../../root_screen.dart';
import '../auth/start_screen.dart';
import 'welcome_screen.dart';
import 'onBording_sceen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      load();
    });
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

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final fRun = prefs.getBool("fRun") ?? true;
    if (fRun) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final email = prefs.getString("email") ?? "";
      final password = prefs.getString("password") ?? "";
      if (email.isNotEmpty && password.isNotEmpty) {
        await login(email, password);
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnBordingScreen()));
      }
    }
  }

  Future<void> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final loginMode = prefs.getString("login_mode") ?? "";
    bool isCorrect = false;

    if (loginMode == "normal") {
      isCorrect = await Provider.of<DataProvider>(context, listen: false)
          .login(email, password);
    } else {
      isCorrect = await Provider.of<DataProvider>(context, listen: false)
          .socialLogin(email, password);
    }
    if (isCorrect) {
      final client = Provider.of<DataProvider>(context, listen: false).client;
      if (client != null) {
        if (client.status == "banned") {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnBordingScreen()));
        } else {
          final position = await _determinePosition(context);
          if (position != null) {
            var point = {
              "type": 'Point',
              "coordinates": [position.longitude, position.latitude]
            };

            await Provider.of<DataProvider>(context, listen: false)
                .updatePosition(point);
            Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
              builder: (BuildContext context) => RootScreen(),
            ));
          }
        }
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
          builder: (BuildContext context) => StartScreen(),
        ));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnBordingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.critical,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/Group2.png')),
            Center(
              child: Image.asset(
                'assets/images/logowhite.png',
                width: 200,
                //fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 1.0, bottom: 1.0),
                child: Image.asset('assets/images/Group1.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
