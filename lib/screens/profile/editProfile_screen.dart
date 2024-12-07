import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/models/user.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/profile/change_pass_screen.dart';
import 'package:testapp/screens/profile/modify_profile_screen.dart';
import 'package:testapp/widgets/delete_profile_alert.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Client? client;
  User? user;
  XFile? selectedImage;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController igcontroller = TextEditingController();

  String code = "";

  Future<void> getImageAndCrop() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            cropStyle: CropStyle.circle,
            toolbarTitle: "Recadrer et ajuster l'image",
            toolbarColor: AppConstants.critical,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            cropStyle: CropStyle.circle,
            title: "Recadrer et ajuster l'image",
            minimumAspectRatio: 1.0,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          selectedImage = XFile(croppedFile.path); // Convert to XFile
        });
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    namecontroller.text = client!.fullName;
    igcontroller.text = client!.instagram;
    biocontroller.text = client!.bio;
    phonecontroller.text = client!.phoneNumber;
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
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
                        Provider.of<DataProvider>(context, listen: false).getClient(client!.id).then((onValue)=>{
                                                  Navigator.of(context).pop()

                        });
                      },
                      iconSize: 24,
                      color: AppConstants.black,
                    ),
                    Text(
                      'Modifier le profil'.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 58,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await getImageAndCrop(); // Select and crop the image
                        if (selectedImage != null) {
                          await Provider.of<DataProvider>(context,
                                  listen: false)
                              .updateClientImage(
                                  selectedImage!); // Upload the image
                          showSnackBar(
                              "Image de profil mise à jour avec succès !");
                        }
                      },
                      child: Stack(
                        children: [
                          ClipOval(
                            child: selectedImage != null
                                ? Image.file(
                                    File(selectedImage!.path),
                                    width: 96,
                                    height: 96,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    AppConstants().serverUrl + client!.imgUrl,
                                    width: 96,
                                    height: 96,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/images/profile.jpg",
                                        width: 96,
                                        height: 96,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                          ),
                          const Positioned(
                              right: 5,
                              bottom: 1,
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.black,
                                  )))
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          client!.fullName.toUpperCase(),
                          style: GoogleFonts.teko(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.black,
                            ),
                          ),
                        ),
                        Text(
                          user!.email,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.critical,
                          ),
                        ),
                      ],
                    ),
                  ],
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
                        keyboardType: TextInputType.emailAddress,
                        controller: namecontroller,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nom Prenom',
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: CountryCodePicker(
                              onChanged: (value) {
                                code = value.dialCode!;
                              },
                              initialSelection: 'TN',
                              favorite: ['+216', 'TN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phonecontroller,
                              maxLength: 10,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                color: Colors.black,
                              ),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Télephone',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppConstants.gray2),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: biocontroller,
                        maxLines: 3,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          color: Colors.black,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'A Propos',
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mot de passe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.black,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Changer le mot de passe',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.gray1,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.navigate_next,
                                color: AppConstants.gray1,
                                size: 16,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const ChangePassScreen(),
                                ));
                              },
                              iconSize: 24,
                              color: AppConstants.black,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppConstants.gray2),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Changer mes details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.black,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Changer mes details',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.gray1,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.navigate_next,
                                color: AppConstants.gray1,
                                size: 16,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const ModifyProfileScreen(),
                                ));
                              },
                              iconSize: 24,
                              color: AppConstants.black,
                            ),
                          ],
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
                        await Provider.of<DataProvider>(context, listen: false)
                            .updateProfile(
                                namecontroller.text,
                                phonecontroller.text,
                                biocontroller.text,
                                igcontroller.text);
                        showSnackBar("Le profil a été modifié");
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppConstants.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35))),
                      child: Text('Enregistrer les changements',
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
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        //Provider.of<DataProvider>(context, listen: false).register(emailcontroller.text, pwdcontroller.text,fnamecontroller.text,phonecontroller.text);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              DeleteProfileAlert(),
                        );
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppConstants.critical,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35))),
                      child: Text('Supprimer le profil',
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
