import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../app_const.dart';
import '../../providers/data_provider.dart';
import '../../widgets/TextButton.dart';

class FilterPeopleScreen extends StatefulWidget {
  const FilterPeopleScreen({super.key});

  @override
  State<FilterPeopleScreen> createState() => _FilterPeopleScreenState();
}

class _FilterPeopleScreenState extends State<FilterPeopleScreen> {
  double SliderValue = 200;
  String gender = '';

  String activity = '';
  RangeValues rangeV = const RangeValues(23, 80);
  List<String> goal = [];

  String frequency = '';
  String club = '';
  String animal = '';
  List<String> language = [];
  String level = '';
  List<String> selectedsport = [];
  List<String> selectedItems = [];

  bool isUpdated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final provider = Provider.of<DataProvider>(context, listen: false);
    gender = provider.gender;
    language = provider.language;
    SliderValue = provider.distance;
    rangeV = RangeValues(provider.minAge, provider.maxAge);
    activity = provider.activity;
    goal = provider.goal;
    frequency = provider.frequency;
    club = provider.club;
    animal = provider.animal;
    level = provider.level;
    selectedsport = provider.selectedsport;
    selectedItems = provider.selectedItems;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // margin: const EdgeInsets.all(16),
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
                        Navigator.of(context).pop(false);
                      },
                      iconSize: 24,
                      color: AppConstants.black,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    'Filtrer les résultats',
                    style: GoogleFonts.teko(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF202226),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
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
                      'Distance',
                      style: GoogleFonts.teko(
                        color: Color(0xFF202226),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                    ),
                  ),
                  Text(
                    'à ${SliderValue.toStringAsFixed(0)} KM'.toUpperCase(),
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
                  activeColor: AppConstants.critical,
                  inactiveColor: AppConstants.line,
                  value: SliderValue,
                  min: 0,
                  max: 500,
                  //divisions: 1,
                  label: SliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      SliderValue = value;
                      isUpdated = true;
                    });
                  }),
              SizedBox(
                height: 50,
              ),
              Text(
                'sexe'.toUpperCase(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(children: [
                    ChoiceChip(
                      label: Text(
                        'Homme',
                        style: TextStyle(
                            color: gender == 'Homme'
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected: gender == 'Homme',
                      onSelected: (selected) {
                        setState(() {
                          gender = selected ? 'Homme' : '';
                          isUpdated = true;
                        });
                      },
                      side: BorderSide(
                          color: AppConstants.line.withOpacity(0.32)),
                      backgroundColor: gender == 'Homme'
                          ? AppConstants.critical
                          : Colors.transparent,
                      selectedColor: AppConstants.critical,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ChoiceChip(
                      label: Text(
                        'Femme',
                        style: TextStyle(
                            color: gender == 'Femme'
                                ? Colors.white
                                : Colors.black),
                      ),
                      selected: gender == 'Femme',
                      onSelected: (selected) {
                        setState(() {
                          gender = selected ? 'Femme' : '';
                          isUpdated = true;
                        });
                      },
                      side: BorderSide(
                          color: AppConstants.line.withOpacity(0.32)),
                      backgroundColor: gender == 'Femme'
                          ? AppConstants.critical
                          : Colors.transparent,
                      selectedColor: AppConstants.critical,
                    ),
                    ChoiceChip(
                      label: Text(
                        'Les deux',
                        style: TextStyle(
                            color: gender == '' ? Colors.white : Colors.black),
                      ),
                      selected: gender == '',
                      onSelected: (selected) {
                        setState(() {
                          gender = selected ? '' : '';
                          isUpdated = true;
                        });
                      },
                      side: BorderSide(
                          color: AppConstants.line.withOpacity(0.32)),
                      backgroundColor: gender == ''
                          ? AppConstants.critical
                          : Colors.transparent,
                      selectedColor: AppConstants.critical,
                    ),
                  ]),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tranche d\'âge'.toUpperCase(),
                      style: GoogleFonts.teko(
                        color: Color(0xFF202226),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    '${rangeV.start.round().toString()} et ${rangeV.end.round().toString()}',
                    style: GoogleFonts.poppins(
                      color: AppConstants.gray1,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.06,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              // Expanded(child: Container()),
              RangeSlider(
                activeColor: AppConstants.critical,
                inactiveColor: AppConstants.line,
                values: rangeV,
                min: 18,
                max: 80,
                labels: RangeLabels(
                  rangeV.start.round().toString(),
                  rangeV.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    rangeV = values;
                    isUpdated = true;
                  });
                },
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //         'Voir les gens 2 ans de chaque \n côté si je suis épuisé'),
              //     Expanded(
              //       child: Container(),
              //     ),
              //     Switch(
              //         value: light,
              //         activeColor: AppConstants.critical,
              //         onChanged: (bool value) {
              //           setState(() {
              //             light = value;
              //           });
              //         })
              //   ],
              // ),
              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VOTRE TYPE D\'ACTIVITÉ'.toUpperCase(),
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
              multichoiceChips(sports, selectedsport, (value) {
                setState(() {
                  selectedsport = value;
                  isUpdated = true;
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
                    'Compétence'.toUpperCase(),
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
              choiceChips(proficiencyLevels, level, (value) {
                setState(() {
                  level = value;
                  isUpdated = true;
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
                    'VOTRE PRINCIPAL OBJECTIF'.toUpperCase(),
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
              multichoiceChips(fitnessGoals, goal, (value) {
                setState(() {
                  goal = value;
                  isUpdated = true;
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
                  isUpdated = true;
                });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'VOTRE FRÉQUENCE D’ENTRAÎNEMENT PAR SEMAINE'
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
              choiceChips(frequencyOptions, frequency, (value) {
                setState(() {
                  frequency = value;
                  isUpdated = true;
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
                    width: MediaQuery.of(context).size.width * 0.8,
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
                  isUpdated = true;
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
                  isUpdated = true;
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
              choiceChips(["Oui, je le souhaite", "Non, Merci"], animal,
                  (value) {
                setState(() {
                  animal = value;
                  isUpdated = true;
                });
              }),
              SizedBox(
                height: 40,
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child:TextButtonWithLoader(
                  onPressed: () async {
                    Provider.of<DataProvider>(context, listen: false)
                        .setFilters(
                            gender,
                            SliderValue,
                            rangeV.start,
                            rangeV.end,
                            frequency,
                            goal,
                            club,
                            animal,
                            language,
                            level,
                            selectedsport,
                            selectedItems);
                    await Provider.of<DataProvider>(context, listen: false)
                        .getClients().then((value) {
                          Navigator.of(context).pop(true);
                        });
                  },
                  text: "Appliquer les filtres",
                  )
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    ));
  }

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
}
