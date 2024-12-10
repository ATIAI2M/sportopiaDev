import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:testapp/app_const.dart';
import 'package:testapp/models/chat.dart';
import 'package:testapp/models/client.dart';
import 'package:testapp/models/message.dart';
import 'package:testapp/providers/data_provider.dart';
import 'package:testapp/screens/matching/rate_client_screen.dart';
import 'package:testapp/widgets/report_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagesScreen extends StatefulWidget {
  final Chat chat;
  final Client client;
  const MessagesScreen({Key? key, required this.chat, required this.client})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<Message> messages = [];

  ScrollController _scrollController = new ScrollController();

  Client? client;

  late IO.Socket socket;

  @override
  void dispose() {
     socket.off(client!.id); // Remove socket listener
  _scrollController.dispose(); // Dispose of the scroll controller
  messageController.dispose();
    super.dispose();
  }

  void _scrollDown() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client = Provider.of<DataProvider>(context, listen: false).client;
    socket = Provider.of<DataProvider>(context, listen: false).socket;
    Provider.of<DataProvider>(context, listen: false).connectToSocket();
    Provider.of<DataProvider>(context, listen: false)
        .getMessages(widget.chat.id)
        .then((value) async {
             if(widget.chat.unseenCount > 0){
     await Provider.of<DataProvider>(context, listen: false).markMessagesAsSeen(Provider.of<DataProvider>(context,listen: false).user.id, widget.chat.id);
    }
      setState(() {
        print(value);
        messages = value;
      });
      _scrollDown();
    });

    print(client!.id);
   socket.on(client!.id, (data) async {
  if (mounted) {
 
   await Provider.of<DataProvider>(context, listen: false)
        .getMessages(widget.chat.id)
        .then((value) {
      if (mounted) {
        setState(() {
          messages = value;
          _scrollDown();
        });
      }
    });
  }
});
  }

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(28, 32, 28, 10),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  ClipOval(
                   child: CachedNetworkImage(
                            imageUrl: AppConstants().serverUrl + widget.client!.imgUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: AutoSizeText(
                            widget.client.fullName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        // Text(
                        //   "Online",
                        //   style: TextStyle(
                        //       color: Colors.grey.shade600, fontSize: 13),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppConstants.line,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppConstants.black2,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(13.0)),
                          ),
                          backgroundColor: Color.fromRGBO(24, 24, 24, 1),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(),
                              height: 220,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 12, 16, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,

                                  children: <Widget>[
                                    Text("Explorer les options",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppConstants.gray1,
                                          ),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Sélectionnez une action à poursuivre",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppConstants.gray1,
                                          ),
                                        )),
                                    Divider(
                                      color: AppConstants.gray1,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        showModalBottomSheet<void>(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(13.0)),
                                          ),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ReportWidget(
                                              client: widget.client,
                                            );
                                          },
                                        );
                                      },
                                      child: Text("Signaler l’utilisateur",
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF0A84FF),
                                            ),
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final client =
                                            Provider.of<DataProvider>(context,
                                                    listen: false)
                                                .client;
                                        await Provider.of<DataProvider>(context,
                                                listen: false)
                                            .deleteMatch(
                                                client!.id, widget.client.id);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      },
                                      child: Text("Annuler le match",
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              RateClientScreen(
                                            client: widget.client,
                                          ),
                                        ));
                                      },
                                      child: Text("Evaluer le partenaire",
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              color: Color(0xFF0A84FF),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      iconSize: 24,
                      color: AppConstants.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  controller: _scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                      top: 10, bottom: 70), // Adjust bottom padding
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].receiverId == client!.id
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].receiverId == client!.id
                                ? Colors.grey.shade200
                                : Colors.black),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].text,
                            style: TextStyle(
                                fontSize: 15,
                                color: messages[index].receiverId == client!.id
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 57,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xFFEDEDED)),
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            fillColor: Colors.grey[200],
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(45.0),
                            ),
                            hintText: "Type your message",
                            hintStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: AppConstants.gray1,
                              ),
                              borderRadius: BorderRadius.circular(45.0),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/images/frame.svg',
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (messageController.text.trim().isNotEmpty) {
                            final msg = messageController.text.trim();
                            messageController.text = "";
                            setState(() {});
                            print(client?.fullName);
                            await Provider.of<DataProvider>(context,  
                                    listen: false)
                                .sendMessage(
                                    widget.chat.id,
                                    widget.chat.receiverId == client!.id
                                        ? widget.chat.senderId
                                        : widget.chat.receiverId,
                                    msg,
                                    client!.fullName);
                         if (mounted) {
  Provider.of<DataProvider>(context, listen: false)
      .sendMessageSocket(widget.client.id);
}

                            Provider.of<DataProvider>(context, listen: false)
                                .getMessages(widget.chat.id)
                                .then((value) {
                              if (mounted) {
                                setState(() {
                                  messages = value;
                                });
                                _scrollDown();
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
