import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';

class EventItem extends StatelessWidget {
  const EventItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => 
                    ),
                  );*/
      },
      child: Stack(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/packDet.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppConstants.line.withOpacity(0.33),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 24,
                      color: Color.fromARGB(255, 220, 2, 2),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              Expanded(child: Container()),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50)),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Total Body Transformation',
                        style: GoogleFonts.teko(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.line)),
                      ),
                      Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/calendarW1.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '10 sessions',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.line,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ClipOval(
                            child: Image.asset(
                              'assets/images/dollarblanc.png',
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
                                color: AppConstants.line,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                            )),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/profile.jpg',
                                width: 18,
                                height: 18,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            ' Coach Nidhal',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.line,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                    ]),
                borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}
