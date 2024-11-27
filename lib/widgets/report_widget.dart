import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/widgets/report_alert.dart';

class ReportWidget extends StatefulWidget {
  final Client client;
  const ReportWidget({super.key, required this.client});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  String reason = "";
  List<String> reasons = [
    "Faux profil",
    "Comportement menaçant",
    "Harcèlement ou intimidation",
    "Discrimination",
    "Discours de haine"
  ];
  TextEditingController detailsController = TextEditingController();
  Widget choiceChips(
      List<String> choices, String val, Function(String) onSelected) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      children: [
        ...choices.map((e) {
          return Padding(
            padding: const EdgeInsets.all(2),
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
    return SizedBox(
      height: 700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Signaler ${widget.client.fullName}'.toUpperCase(),
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.gray1),
                      )),
                  IconButton(onPressed: () {}, icon: Icon(Icons.close))
                ],
              ),
            ),
          ),
          Text('S’il vous plaît laissez-nous savoir les raisons',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppConstants.gray1,
                ),
              )),
          SizedBox(
            height: 18,
          ),
          choiceChips(reasons, reason, (value) {
            setState(() {
              reason = value;
            });
          }),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: detailsController,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ajouter des détails (optionnel)',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.07,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16),
              child: TextButton(
                onPressed: () async {
                  if (reason.isNotEmpty) {
                    await Provider.of<DataProvider>(context, listen: false)
                        .claim(
                            widget.client.id, reason, detailsController.text);
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ReportAlert(),
                    );
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: AppConstants.critical,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 5, 80, 5),
                  child: Text('Rapport utilisateur',
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
            height: 20,
          ),
        ],
      ),
    );
  }
}
