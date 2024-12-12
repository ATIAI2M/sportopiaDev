import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_const.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/loading_screen.dart';
import 'screens/home/notification_screen.dart';
import 'screens/home/settings_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void _selectedTab(int index) {
    setState(() {
      if (currentIndex != index) {
        pageController.jumpToPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          // drawer: AppDrawer(),
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              LoadingScreen(),
              ChatScreen(),
              NotificationScreen(),
              Settingscreen(),
            ],
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        
          bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/home.svg',
                    color: currentIndex == 0 ? AppConstants.critical : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/discover.svg',
                    color: currentIndex == 1 ? AppConstants.critical : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/comment-text.svg',
                    color: currentIndex == 2 ? AppConstants.critical : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/bell.svg',
                    color: currentIndex == 3 ? AppConstants.critical : null,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/Settings.svg',
                    color: currentIndex == 4 ? AppConstants.critical : null,
                  ),
                  label: '',
                ),
              ],
              type: BottomNavigationBarType.shifting,
              currentIndex: currentIndex,
              selectedItemColor: AppConstants.critical,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              //iconSize: 40,
              onTap: _selectedTab,
              elevation: 5),
        ),
      ),
    );
  }
}
