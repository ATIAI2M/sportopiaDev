import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';

class MatchingItem extends StatefulWidget {
  const MatchingItem({super.key});

  @override
  State<MatchingItem> createState() => _MatchingItemState();
}

class _MatchingItemState extends State<MatchingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            Color(0xFF3A3C34),
            Color(0xFF262528),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      height: 340,
      width: 350,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
          ),
          ClipOval(
            child: Image.asset(
              'assets/images/profile.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Omar'.toUpperCase(),
            style: GoogleFonts.teko(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEDEDED),
              ),
            ),
          ),
          Text(
            'À 12 Km'.toUpperCase(),
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFFEDEDED),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Color.fromRGBO(145, 158, 171, 0.32),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
              child: Text(
                textAlign: TextAlign.center,
                'À la recherche d’un compagnon de Padel',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.gray2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 251, 236, 236),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: AppConstants.critical,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute<void>(
                  //   builder: (BuildContext context) =>
                  //       const MatchedFilterScreen(),
                  // ));
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 71, 85, 0.43),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/heart.svg',
                      color: Color(0xFFFD4755),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 45,
          )
        ],
      ),
    );
  }
}
