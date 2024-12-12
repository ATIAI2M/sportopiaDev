import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_const.dart';
import '../models/chat.dart';
import '../models/client.dart';
import '../providers/data_provider.dart';
import '../screens/chat/messages_screen.dart';

class MessagesItem extends StatefulWidget {
  final Client client;
  final Chat chat;
  const MessagesItem({super.key, required this.chat, required this.client});

  @override
  State<MessagesItem> createState() => _MessagesItemState();
}
class _MessagesItemState extends State<MessagesItem> {
 String formatDate(String dateString) {
  print(dateString);
  final parts = dateString.split(' ');
  final dateParts = parts[0].split('-').map(int.parse).toList();
  final timeParts = parts[1].split(':').map(int.parse).toList();

  final date = DateTime(dateParts[0], dateParts[1], dateParts[2], timeParts[0], timeParts[1]);

  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
    return 'Hier';
  } else {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        widget.chat.unseenCount > 0 ? Colors.grey.shade300 : Colors.white,

        border: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 222, 222, 222),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: ListTile(
        tileColor:  widget.chat.unseenCount > 0 ? Colors.grey.shade100 : Colors.white,
        onTap: () async {
      
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (BuildContext context) => MessagesScreen(
                chat: widget.chat,
                client: widget.client,
              ),
            ));
      
            print("Unseen count: ${widget.chat.unseenCount}");
          }
         
        ,
        leading: ClipOval(
          child: Image.network(
            AppConstants().serverUrl + widget.client.imgUrl,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/images/profile.jpg",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.client.fullName,
                      style: GoogleFonts.teko(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                   
                  ],
                ),
                  Text(
          widget.chat.lastReceivedMessage ?? "No messages yet",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
              ],
            ),
            SizedBox(
              width: 60,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                Text(
                 formatDate( widget.chat.updatedAt.substring(0, 16).replaceFirst("T", " ")),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.black2,
                    ),
                  ),
                  
                ),
                SizedBox(height: 5,),
                widget.chat.unseenCount >0 ? Badge.count(
                  count: widget.chat.unseenCount,
                  backgroundColor: AppConstants.critical,
                  textStyle: const TextStyle(color: Colors.white),
      
      
                  ):Badge(
                                    backgroundColor: AppConstants.white,
      
                  )
      
      
                // Badge(
                //   padding: EdgeInsets.all(5),
                //   largeSize: 35,
                //   smallSize: 30,
                //   textStyle:  TextStyle(fontSize: 24),
                //   label: Text("${widget.chat.unseenCount}",),
                //   textColor: Colors.white,
                //   backgroundColor: AppConstants.critical,
      
                // )
              ],
            )
          ],
        ),
       
      ),
    );
  }
}
