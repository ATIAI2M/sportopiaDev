import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
//import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/root_screen.dart';
import 'package:testapp/screens/auth/activate_location_screen.dart';
import 'package:testapp/screens/auth/start_screen.dart';

import '../../providers/data_provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  //String goal = '';

  String gender = '';
  String frequency = '';
  String club = '';
  String animal = '';
  List<String> language = [];
  String level = '';
  List<String> selectedsport = [];
  List<String> selectedItems = [];
  List<String> selectedGoals = [];
  int step = 1;
  Country country = Country.parse("Tunisia");
  TextEditingController regioncontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  // String stateValue = "";
  // String cityValue = "";

  String code = "";

  double height = 175;
  double weight = 70;

  String? dropdownValueSport;

  TextEditingController agecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController biocontroller = TextEditingController();
  TextEditingController igcontroller = TextEditingController();

  XFile? selectedImage;

  List<String> proficiencyLevels = [
    "Débutant",
    "Intermédiaire",
    "Avancé",
  ];

  List<String> frequencyOptions = [
    "0",
    "1",
    "2",
    "3",
    "4 ou plus",
  ];
  List<String> equipmentItems = [
    "Ballon",
    "Raquette",
    "Gants",
    "Vélo",
    "Planche de Surf",
    "Haltères",
    "Corde à Sauter",
    "Équipement de Plongée",
    "Raquette de Tennis",
    "Casque",
    "Tapis de Yoga",
    "Gants de Boxe",
    "Équipement de Golf",
    "Autre équipement",
  ];
  List<String> languages = [
    "Anglais",
    "Français",
    "Espagnol",
    "Allemand",
    "Italien",
    "Chinois",
    "Japonais",
    "Portugais",
    "Russe",
    "Arabe",
    "Coréen",
    "Néerlandais",
    "Suédois",
    "Langue des Signes (LSF)"
  ];

  List<String> genders = ["Homme", "Femme"];
  List<String> sports = [
    "Tennis",
    "Padel",
    "Football",
    "Course à pied",
    "Basketball",
    "Vélo",
    "Natation",
    "Golf",
    "Yoga",
    "Fitness",
    "Escalade",
    "Musculation",
    "Cyclisme",
    "Danse",
    "Pilates",
    "Surf",
    "Paddle",
    "Kayak",
    "Arts martiaux",
    "Randonnée",
    "Volley-ball",
    "Rugby",
    "Handball",
    "Entraînement en circuit",
    "Badminton",
    "Boxe",
    "Kickboxing",
    "Judo",
    "Thai Boxing",
    "Aérobic",
    "Marche rapide",
    "Gymnastique",
    "CrossFit",
    "Course de vélo",
    "Aviron",
    "Fitness en Outdoor",
    "Equitation",
    "Ping-pong",
    "Squash",
    "Canoë-kayak",
    "Pétanque",
    "Autre",
  ];

  List<String> fitnessGoals = [
    "Perdre du poids",
    "Gagner en muscle",
    "Améliorer votre condition physique générale",
    "Préparer une compétition",
    "Rester en forme et en bonne santé",
  ];

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.displayName != null) {
      namecontroller.text = FirebaseAuth.instance.currentUser!.displayName!;
    }
  }

  bool isLoading = false;

  Widget choiceChips(
      List<String> choices, String val, Function(String) onSelected) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        ...choices.map((e) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ChoiceChip(
              label: Text(
                e,
                style: TextStyle(
                  color: val == e ? Colors.white : Colors.black,
                ),
              ),
              selected: val == e,
              onSelected: (selected) {
                onSelected(selected ? e : '');
              },
              side: BorderSide(color: Colors.grey.withOpacity(0.32)),
              backgroundColor: val == e ? Colors.red : Colors.transparent,
              selectedColor: Colors.red,
            ),
          );
        })
      ],
    );
  }

  Widget multichoiceChips(List<String> choices, List<String> selectedchoices,
      Function(List<String>) onSelected) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        ...choices.map((e) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: ChoiceChip(
              label: Text(
                e,
                style: TextStyle(
                  color:
                      selectedchoices.contains(e) ? Colors.white : Colors.black,
                ),
              ),
              selected: selectedchoices.contains(e),
              onSelected: (selected) {
                List<String> updatedList = List.from(selectedchoices);
                if (selected) {
                  updatedList.add(e);
                } else {
                  updatedList.remove(e);
                }
                onSelected(updatedList);
              },
              side: BorderSide(color: Colors.grey.withOpacity(0.32)),
              backgroundColor:
                  selectedchoices.contains(e) ? Colors.red : Colors.transparent,
              selectedColor: Colors.red,
            ),
          );
        })
      ],
    );
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
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

  ScrollController controller = ScrollController();

  void _scrollTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.minScrollExtent);
    });
  }

  Map<String, String> selectedsports = {};

  Widget sportWidget() {
    return Column(
      children: [
        ...selectedsports.keys.map((e) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(e),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        selectedsports[e]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        selectedsports.remove(e);
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      )),
                ],
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
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
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                          color: AppConstants.line,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () {
                          if (step > 1) {
                            setState(() {
                              step--;
                            });
                            _scrollTop();
                          } else {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const StartScreen(),
                            ));
                          }
                        },
                        iconSize: 24,
                        color: AppConstants.black,
                      ),
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Container(
                      width: 28,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: AppConstants.critical,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(104),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 28,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: step >= 2
                            ? AppConstants.critical
                            : AppConstants.line,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(104),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 28,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: step >= 3
                            ? AppConstants.critical
                            : AppConstants.line,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(104),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: 28,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: step >= 4
                            ? AppConstants.critical
                            : AppConstants.line,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(104),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      '$step/4',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.teko(
                        color: Color(0xFFA2A5B1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 0.09,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                if (step == 1) StepOne(),
                if (step == 2) StepTwo(),
                if (step == 3) StepThree(),
                if (step == 4) StepFour(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (step < 4) {
                              if (step == 1) {
                                if (gender.isEmpty) {
                                  showSnackBar("Sexe (obligatoire)");
                                } else if (regioncontroller.text.isEmpty) {
                                  showSnackBar("Region (obligatoire)");
                                } else if (citycontroller.text.isEmpty) {
                                  showSnackBar("Ville (obligatoire)");
                                } else if (agecontroller.text.isEmpty) {
                                  showSnackBar("Age (obligatoire)");
                                } else {
                                  setState(() {
                                    step++;
                                  });
                                }
                              }
                              if (step == 2) {
                                if (selectedsports.isEmpty) {
                                  showSnackBar(
                                      "Sports Pratiqués/Préférés (obligatoire)");
                                } else if (selectedGoals.isEmpty) {
                                  showSnackBar(
                                      "Objectif Principal (obligatoire)");
                                } else {
                                  setState(() {
                                    step++;
                                  });
                                }
                              }

                              if (step == 3) {
                                if (frequency.isEmpty) {
                                  showSnackBar(
                                      "Fréquence d'Entraînement (obligatoire)");
                                } else if (club.isEmpty) {
                                  showSnackBar(
                                      "Expérience Passée (obligatoire)");
                                } else if (selectedItems.isEmpty) {
                                  showSnackBar("Équipement (obligatoire)");
                                } else if (animal.isEmpty) {
                                  showSnackBar(
                                      "Marche avec des animaux (obligatoire)");
                                } else if (language.isEmpty) {
                                  showSnackBar("Langues Parlées (obligatoire)");
                                } else {
                                  setState(() {
                                    step++;
                                  });
                                }
                              }

                              if (step < 3) {
                                _scrollTop();
                              }
                            } else if (step == 4) {
                              if (selectedImage == null) {
                                showSnackBar("Image (obligatoire)");
                              } else if (regioncontroller.text.isEmpty) {
                                showSnackBar("Region (obligatoire)");
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
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

                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    Client client = Client(
                                        id: "",
                                        userId: "",
                                        token: "",
                                        phoneNumber:
                                            code + phonecontroller.text,
                                        fullName: namecontroller.text,
                                        age: int.parse(agecontroller.text),
                                        gender: gender,
                                        imgUrl: "",
                                        rate: 0,
                                        status: "active",
                                        verification: "yes",
                                        position: point,
                                        sports: selectedsports,
                                        items: selectedItems,
                                        language: language,
                                        goal: selectedGoals,
                                        frequency: frequency,
                                        club: club,
                                        animal: animal,
                                        level: level,
                                        country: country.name,
                                        region: regioncontroller.text,
                                        city: citycontroller.text,
                                        bio: biocontroller.text.isEmpty
                                            ? "Vide"
                                            : biocontroller.text,
                                        instagram: igcontroller.text.isEmpty
                                            ? "Vide"
                                            : igcontroller.text,
                                        height: height.round().toDouble(),
                                        weight: weight.round().toDouble());

                                    await Provider.of<DataProvider>(context,
                                            listen: false)
                                        .createClient(
                                            client,
                                            "${position.latitude}",
                                            "${position.longitude}",
                                            selectedImage!);
                                    await _googleSignIn.disconnect();
                                    await FirebaseAuth.instance.signOut();
                                  } else {
                                    Client client = Client(
                                        id: "",
                                        userId: "",
                                        token: "",
                                        phoneNumber:
                                            code + phonecontroller.text,
                                        fullName: namecontroller.text,
                                        age: int.parse(agecontroller.text),
                                        gender: gender,
                                        imgUrl: "",
                                        rate: 0,
                                        status: "active",
                                        verification: "yes",
                                        position: point,
                                        sports: selectedsports,
                                        items: selectedItems,
                                        language: language,
                                        goal: selectedGoals,
                                        frequency: frequency,
                                        club: club,
                                        animal: animal,
                                        level: level,
                                        country: country.name,
                                        region: regioncontroller.text,
                                        city: citycontroller.text,
                                        bio: biocontroller.text.isEmpty
                                            ? "Vide"
                                            : biocontroller.text,
                                        instagram: igcontroller.text.isEmpty
                                            ? "Vide"
                                            : igcontroller.text,
                                        height: height.round().toDouble(),
                                        weight: weight.round().toDouble());

                                    await Provider.of<DataProvider>(context,
                                            listen: false)
                                        .createClient(
                                            client,
                                            "${position.latitude}",
                                            "${position.longitude}",
                                            selectedImage!);
                                  }

                                  await Provider.of<DataProvider>(context,
                                          listen: false)
                                      .updateClientImage(selectedImage!);

                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        RootScreen(),
                                  ));
                                } else {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ActivateLocationScreen(),
                                  ));
                                }
                              }
                            }
                            setState(() {
                              isLoading = false;
                            });
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
                        : Text(step == 4 ? "Terminer" : 'Etape suivante',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.white,
                            ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget StepOne() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vous etês'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        choiceChips(genders, gender, (value) {
          setState(() {
            gender = value;
          });
        }),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quel est Votre Pays'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Card(
          elevation: 3,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            onTap: () {
              showCountryPicker(
                context: context,
                countryListTheme: CountryListThemeData(
                  flagSize: 25,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  bottomSheetHeight: 500, // Optional. Country list modal height
                  //Optional. Sets the border radius for the bottomsheet.
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  //Optional. Styles the search field.
                  inputDecoration: InputDecoration(
                    labelText: 'Recherche',
                    hintText: 'Commencez à taper pour rechercher',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                onSelect: (Country ct) {
                  setState(() {
                    country = ct;
                  });
                },
              );
            },
            leading: Text(
              country.flagEmoji,
              style: TextStyle(fontSize: 25),
            ),
            title: Text(country.name),
            trailing: Icon(Icons.arrow_drop_down_sharp),
          ),
        ),

        TextFormField(
          keyboardType: TextInputType.name,
          controller: regioncontroller,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Region',
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: citycontroller,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Ville',
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Text(
              'Quel est votre âge'.toUpperCase(),
              //textAlign: TextAlign.start,
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: agecontroller,
          showCursor: false,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: GoogleFonts.teko(
            color: Color(0xFF202226),
            fontSize: 30,
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
        ),
        //Expanded(child: Container()),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Votre taille'.toUpperCase(),
                style: GoogleFonts.teko(
                  color: AppConstants.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 0.06,
                ),
              ),
            ),
            Text(
              '${height.toStringAsFixed(0)} CM'.toUpperCase(),
              style: GoogleFonts.poppins(
                color: AppConstants.gray1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.06,
              ),
            ),
          ],
        ),

        Slider(
            activeColor: Colors.black,
            inactiveColor: AppConstants.line,
            value: height,
            min: 100,
            max: 250,
            //divisions: 1,
            label: height.round().toString(),
            onChanged: (double value) {
              setState(() {
                height = value;
              });
            }),

        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Votre poids'.toUpperCase(),
                style: GoogleFonts.teko(
                  color: AppConstants.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 0.06,
                ),
              ),
            ),
            Text(
              weight == 200
                  ? '${weight.toStringAsFixed(0)}+ KG'.toUpperCase()
                  : '${weight.toStringAsFixed(0)} KG'.toUpperCase(),
              style: GoogleFonts.poppins(
                color: AppConstants.gray1,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 0.06,
              ),
            ),
          ],
        ),

        Slider(
            activeColor: Colors.black,
            inactiveColor: AppConstants.line,
            value: weight,
            min: 30,
            max: 200,
            //divisions: 1,
            label: weight.round().toString(),
            onChanged: (double value) {
              setState(() {
                weight = value;
              });
            }),
      ],
    );
  }

  Widget StepTwo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sports Pratiqués/Préférés'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(13.0)),
                    ),
                    //backgroundColor: Color.fromRGBO(24, 24, 24, 1),
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) => Container(
                          decoration: const BoxDecoration(),
                          height: 420,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Nouveau sport".toUpperCase(),
                                    style: GoogleFonts.teko(
                                      textStyle: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: AppConstants.gray1,
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("sport".toUpperCase(),
                                    style: GoogleFonts.teko(
                                      textStyle: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        //color: AppConstants.gray1,
                                      ),
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 30),
                                  child: DropdownButton<String>(
                                    underline: Container(), isExpanded: true,
                                    menuMaxHeight: 400,
                                    // Initial Value
                                    value: dropdownValueSport,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    dropdownColor: Colors.white,

                                    // Down Arrow Icon
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.black,
                                    ),
                                    hint: Text(
                                      "Choisir le sport",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // Array list of items
                                    items: sports.map((String sp) {
                                      return DropdownMenuItem(
                                        value: sp,
                                        child: Text(
                                          sp,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),

                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValueSport = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Compétence'.toUpperCase(),
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
                                choiceChips(proficiencyLevels, level, (value) {
                                  setState(() {
                                    level = value;
                                  });
                                }),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  child: TextButton(
                                    onPressed: () {
                                      selectedsports.putIfAbsent(
                                          dropdownValueSport!, () => level);
                                      level = '';
                                      dropdownValueSport = null;
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: AppConstants.critical,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(35))),
                                    child: Text('Ajouter',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppConstants.white,
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                  setState(() {});
                },
                child: Text(
                  "Ajouter",
                  style: GoogleFonts.teko(
                    color: Color(0xFF3287FF),
                    fontSize: 18,
                  ),
                ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // multichoiceChips(sports, selectedsport, (value) {
        //   setState(() {
        //     selectedsport = value;
        //   });
        // }),
        StatefulBuilder(
          builder: (context, setState) => sportWidget(),
        ),
        SizedBox(
          height: 40,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Compétence'.toUpperCase(),
        //       style: GoogleFonts.teko(
        //         color: Color(0xFF202226),
        //         fontSize: 24,
        //         fontWeight: FontWeight.w600,
        //         height: 0.06,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 20,
        // ),
        // choiceChips(proficiencyLevels, level, (value) {
        //   setState(() {
        //     level = value;
        //   });
        // }),
        // SizedBox(
        //   height: 40,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Objectif Principal'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        multichoiceChips(fitnessGoals, selectedGoals, (value) {
          setState(() {
            selectedGoals = value;
          });
        }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget StepThree() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Text(
                'Fréquence d\'Entraînement Souhaitée'.toUpperCase(),
                style: GoogleFonts.teko(
                  color: Color(0xFF202226),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        choiceChips(frequencyOptions, frequency, (value) {
          setState(() {
            frequency = value;
          });
        }),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Text(
                'Expérience Passée avec des Équipes ou Clubs Sportifs'
                    .toUpperCase(),
                style: GoogleFonts.teko(
                  color: Color(0xFF202226),
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        choiceChips(["Oui", "Non"], club, (value) {
          setState(() {
            club = value;
          });
        }),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Équipement'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        multichoiceChips(equipmentItems, selectedItems, (value) {
          setState(() {
            selectedItems = value;
          });
        }),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Marche avec des animaux'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        choiceChips(["Oui, Je souhaite", "Non, Merci"], animal, (value) {
          setState(() {
            animal = value;
          });
        }),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Langues Parlées'.toUpperCase(),
              style: GoogleFonts.teko(
                color: Color(0xFF202226),
                fontSize: 24,
                fontWeight: FontWeight.w600,
                height: 0.06,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        multichoiceChips(languages, language, (value) {
          setState(() {
            language = value;
          });
        }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget StepFour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: InkWell(
            onTap: () async {
              await getImage();
            },
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(145, 158, 171, 0.32),
              radius: 80,
              backgroundImage: selectedImage == null
                  ? null
                  : Image.file(
                      File(selectedImage!.path),
                      fit: BoxFit.cover,
                    ).image,
              child: selectedImage == null
                  ? Center(
                      child: Image.asset("assets/images/camera.png"),
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: namecontroller,
          maxLength: 50,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nom Prenom',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Un bio sympa ouvre la porte à des connexions authentiques" , style: GoogleFonts.teko(
            //     color: Color(0xFF202226),
            //     fontSize: 22,
            //     fontWeight: FontWeight.w600,
            //   ),),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: biocontroller,
              maxLines: 3,
              maxLength: 500,
              
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                    floatingLabelBehavior:FloatingLabelBehavior.always,

                labelText: 'A propos',
                hintText: "Un bon partenaire commence par une bonne présentation. 🏅 Partage qui tu es et ce que tu cherches !",
                border: UnderlineInputBorder(),
                // labelText: 'A propos',
              ),
              
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        
      ],
    );
  }
}
