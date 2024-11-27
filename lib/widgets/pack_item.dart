import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/screens/old/packDetail_screen.dart';

class PackItem extends StatelessWidget {
  const PackItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PackDetailScreen()));
      },
      child: Container(
        height: 236,
        child: Card(
          child: Row(
            children: [
              Image.asset(
                'assets/images/pack.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 12,
              ),
              Column(children: [
                Text(
                  'Building Lean Muscle \n for Beginners'.toUpperCase(),
                  style: GoogleFonts.teko(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFA6A6A6),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/calendarW2.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '10 sessions',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.critical,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/dollarrouge.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '259 TND',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.critical,
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
