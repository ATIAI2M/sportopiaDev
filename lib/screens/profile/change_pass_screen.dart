import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/models/user.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/widgets/delete_profile_alert.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  Client? client;
  User? user;

  TextEditingController oldcontroller = TextEditingController();
  TextEditingController newcontroller = TextEditingController();
  TextEditingController cnewcontroller = TextEditingController();

  void showSnackBar(bool isError, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green,
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
    client = Provider.of<DataProvider>(context).client;
    user = Provider.of<DataProvider>(context).user;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppConstants.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 24,
                      color: AppConstants.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 58,
                ),
                Text(
                  'Réinitialisation de Mot de Passe'.toUpperCase(),
                  style: GoogleFonts.teko(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: oldcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Mot de passe actuel',
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: newcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nouveau mot de passe',
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: cnewcontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Confirmer le mot de passe',
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () async {
                        if (oldcontroller.text.isNotEmpty &&
                            newcontroller.text.isNotEmpty &&
                            cnewcontroller.text == newcontroller.text) {
                          final res = await Provider.of<DataProvider>(context,
                                  listen: false)
                              .updatePass(
                                  oldcontroller.text, newcontroller.text);
                          if (res) {
                            showSnackBar(false, "Mot de passe modifié");
                            Navigator.of(context).pop();
                          } else {
                            showSnackBar(true, "Mot de passe incorrect!");
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppConstants.critical,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35))),
                      child: Text('Confirmer ',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
