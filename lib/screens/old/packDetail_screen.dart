import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/screens/home/loading_screen.dart';

class PackDetailScreen extends StatefulWidget {
  const PackDetailScreen({super.key});

  @override
  State<PackDetailScreen> createState() => _PackDetailScreenState();
}

class _PackDetailScreenState extends State<PackDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 400,
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/packDet.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 22, 28, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(top: 62),
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
                            Navigator.of(context).pop();
                          },
                          iconSize: 24,
                          color: AppConstants.line,
                        ),
                      ),
                      Expanded(child: Container()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Featured',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Total Body Transformation',
                            style: GoogleFonts.teko(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.line)),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
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
                              Icon(
                                Icons.monetization_on,
                                color: AppConstants.line,
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
                              ClipOval(
                                child: Image.asset(
                                  'assets/images/profile.jpg',
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.cover,
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
                            height: 20,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 21.0, right: 35),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ABOUT',
                      style: GoogleFonts.teko(
                        color: AppConstants.gray1,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        'Creating a vibrant connection between well-being and art coaches and enthusiasts through like-minded communities to cultivate a harmonious and inspiring environment.',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            color: AppConstants.gray1),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'DETAILS',
                      style: GoogleFonts.teko(
                        color: AppConstants.gray1,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 0.06,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
