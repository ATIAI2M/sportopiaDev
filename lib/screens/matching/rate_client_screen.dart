import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/widgets/review_alert.dart';

class RateClientScreen extends StatefulWidget {
  final Client client;
  const RateClientScreen({super.key, required this.client});

  @override
  State<RateClientScreen> createState() => _RateClientScreenState();
}

class _RateClientScreenState extends State<RateClientScreen> {
  String one = '';
  String two = '';
  String three = '';
  String four = '';

  List<String> question1 = [
    "Pas du tout",
    "Pas très bien",
    "Moyennement bien",
    "Bien",
    "Très bien"
  ];

  List<String> question2 = [
    "Pas du Tout Ponctuel(le)",
    "Pas Très Ponctuel(le)",
    "Neutre",
    "Ponctuel(le)",
    "Très Ponctuel(le)"
  ];

  List<String> question3 = [
    "Pas du tout",
    "Pas très bien",
    "Moyennement bien",
    "Bien",
    "Très bien"
  ];

  List<String> question4 = [
    "Oui",
    "Non",
  ];

  int rate = 0;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text('Évaluer ${widget.client.fullName}'.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF202226),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(
                      'Dans quelle mesure la rencontre avec votre partenaire sportif a-t-elle répondu à vos attentes ? '
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
              choiceChips(question1, one, (value) {
                setState(() {
                  one = value;
                });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(
                      'À quel point votre partenaire était-il/elle ponctuel(le) pour la session d\'entraînement ou d\'activité sportive ?'
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
              choiceChips(question2, two, (value) {
                setState(() {
                  two = value;
                });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(
                      'Avez-vous trouvé que la session d\'entraînement ou d\'activité sportive était adaptée à vos préférences et objectifs ?'
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
              choiceChips(question3, three, (value) {
                setState(() {
                  three = value;
                });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(
                      'Recommanderiez-vous votre partenaire comme partenaire sportif à d\'autres utilisateurs de l\'application ?'
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
              choiceChips(question4, four, (value) {
                setState(() {
                  four = value;
                });
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Text(
                      'À quel point recommanderiez-vous l\'application de rencontres sportives en fonction de votre expérience.'
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
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xFFFD4755),
                ),
                onRatingUpdate: (rating) {
                  rate = rating.toInt();
                },
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: TextButton(
                    onPressed: () async {
                      if (one.isNotEmpty &&
                          two.isNotEmpty &&
                          three.isNotEmpty &&
                          four.isNotEmpty &&
                          rate != 0) {
                        await Provider.of<DataProvider>(context, listen: false)
                            .addReview(rate, "$one/$two/$three/$four",
                                widget.client.id);
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => ReviewAlert(),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: AppConstants.critical,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 5, 50, 5),
                      child: Text('Envoyer des commentaires',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.white,
                          ))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
