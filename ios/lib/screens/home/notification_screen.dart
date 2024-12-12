import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/client.dart';
import '../../models/notification.dart';
import '../../providers/data_provider.dart';
import '../../widgets/emptyNotification_widget.dart';
import '../../widgets/notification_item.dart';

import '../../app_const.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Client? client;
  List<Notif> notifications = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    Provider.of<DataProvider>(context, listen: false).getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    notifications = Provider.of<DataProvider>(context).notifications;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 39, 28, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        AppConstants().serverUrl + client!.imgUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/profile.jpg",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifications',
                          style: GoogleFonts.teko(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.black,
                            ),
                          ),
                        ),
                        Text(
                          'Voir vos notifications',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                              color: AppConstants.gray1),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 40,
            ),
            notifications.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: notifications.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {},
                              child: NotificationItem(
                                notif: notifications[index],
                              ));
                        },
                      ),
                    ),
                  )
                : EmptyNotification()
          ],
        ),
      ),
    ));
  }
}
