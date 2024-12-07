import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testapp/widgets/TextButton.dart';

class ActivateLocationScreen extends StatefulWidget {
  const ActivateLocationScreen({
    super.key,
  });

  @override
  State<ActivateLocationScreen> createState() => _ActivateLocationScreenState();
}

class _ActivateLocationScreenState extends State<ActivateLocationScreen> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(),
              Column(
                children: [
                  Image.asset("assets/images/location.png"),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Activez le suivi de la localisation'.toUpperCase(),
                    style: GoogleFonts.teko(
                      color: Color(0xFF202226),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 0.06,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Pour profiter de toutes les fonctionnalités de notre application!\nL\'activation du suivi de la localisation nous permettra de vous proposer des fonctionnalités plus personnalisée.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextButtonWithLoader(onPressed: () async {
                      final position = await _determinePosition(context);
                      if (position != null) {
                        Navigator.of(context).pop();
                      }
                    }, text: "Activer")
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
