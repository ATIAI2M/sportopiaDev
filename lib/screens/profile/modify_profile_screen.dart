import 'dart:io';

//import 'package:csc_picker/csc_picker.dart';
import 'package:country_picker/country_picker.dart';
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

class ModifyProfileScreen extends StatefulWidget {
  const ModifyProfileScreen({Key? key}) : super(key: key);

  @override
  _ModifyProfileScreenState createState() => _ModifyProfileScreenState();
}

class _ModifyProfileScreenState extends State<ModifyProfileScreen> {
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

  double height = 175;
  double weight = 70;

  TextEditingController agecontroller = TextEditingController();

  String? dropdownValueSport;

  ScrollController controller = ScrollController();

  void _scrollTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.jumpTo(controller.position.minScrollExtent);
    });
  }

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
    "Padel" ,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final client = Provider.of<DataProvider>(context, listen: false).client;
    agecontroller.text = client!.age.toString();
    selectedGoals = client.goal;

    gender = client.gender;
    frequency = client.frequency;
    club = client.club;
    animal = client.animal;
    language = client.language;
    level = client.level;
    selectedsports = client.sports;
    selectedItems = client.items;

    country = Country.parse(client.country);
    regioncontroller.text = client.region;
    citycontroller.text = client.city;

    height = client.height;
    weight = client.weight;
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
                            Navigator.of(context).pop();
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
                    Expanded(child: Container()),
                    Text(
                      '$step/3',
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
                            if (step < 3) {
                              setState(() {
                                step++;
                              });

                              _scrollTop();
                            } else if (step == 3) {
                              Client client = Client(
                                  id: "",
                                  userId: "",
                                  token: "",
                                  phoneNumber: "",
                                  fullName: "",
                                  age: int.parse(agecontroller.text),
                                  gender: gender,
                                  imgUrl: "",
                                  rate: 0,
                                  status: "active",
                                  verification: "yes",
                                  position: {},
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
                                  bio: "",
                                  instagram: "",
                                  height: height,
                                  weight: weight);

                              await Provider.of<DataProvider>(context,
                                      listen: false)
                                  .updateClient(
                                client,
                              );

                              Navigator.of(context).pop();
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
                        : Text(step == 3 ? "Terminer" : 'Etape suivante',
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
                'VOTRE FRÉQUENCE D’ENTRAÎNEMENT PAR SEMAINE'.toUpperCase(),
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
                'VOUS AVEZ FAIT PARTIE D’UNE ÉQUIPE OU D’UN CLUB SPORTIF '
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
              'VOTRE ÉQUIPEMENT SPORTIF'.toUpperCase(),
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
              'PRÉSENCE D’UN ANIMAL DE CAMPAGNIE'.toUpperCase(),
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
        choiceChips(["Oui, je le souhaite", "Non, Merci"], animal, (value) {
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
}
