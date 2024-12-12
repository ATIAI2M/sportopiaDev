import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/auth/login_screen.dart';
import 'package:testapp/screens/profile/editProfile_screen.dart';
import 'package:testapp/screens/home/filterPeople_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  Client? client;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
     WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<DataProvider>(context, listen: false).getClient(client!.id);
  });
   
   
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'paramètres'.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                //padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                      
                          imageUrl: AppConstants().serverUrl + client!.imgUrl,
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                           placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                          
                        
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          client!.fullName,
                          style: GoogleFonts.teko(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.black,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const EditProfileScreen(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/Settings.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paramètres',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.black,
                              ),
                            ),
                          ),
                          Text(
                            'Modifier les paramètres de notification',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.gray1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: AppConstants.gray1,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const EditProfileScreen(),
                          ));
                        },
                        iconSize: 24,
                        color: AppConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse('https://sportopia.tn/#/privacy'));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/shield.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Politique de confidentialité',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.black,
                              ),
                            ),
                          ),
                          Text(
                            'Consultez notre politique de confidentialité',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.gray1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: AppConstants.gray1,
                        ),
                        onPressed: () {
                          /*
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const StartScreen(),
                            ));*/
                        },
                        iconSize: 24,
                        color: AppConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse('https://sportopia.tn/#/contact'));
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/help.png',
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aide et support',
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Text(
                              'Consultez notre section d’aide pour trouver des solutions',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.gray1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: Icon(
                          Icons.navigate_next,
                          color: AppConstants.gray1,
                        ),
                        onPressed: () {
                          /*
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const StartScreen(),
                            ));*/
                        },
                        iconSize: 24,
                        color: AppConstants.black,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: Colors.grey),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.remove("login_mode");
                      await prefs.remove("email");
                      await prefs.remove("password");
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppConstants.critical,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                    child: Text('Déconnexion',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.white,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
