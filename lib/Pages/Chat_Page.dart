import 'package:firebase/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import 'Chat_Bubble.dart';

class Chat_Page extends StatefulWidget {
  Chat_Page({super.key});
  static String id = "ChatPage";

  @override
  State<Chat_Page> createState() => _Chat_PageState();
}

class _Chat_PageState extends State<Chat_Page> {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    //QuerySnapshot snapshot = await messages.orderBy('date', descending: false).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<Message> MessagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            MessagesList.add(Message.fromjson(snapshot.data!.docs[i]));
            //  print(snapshot.data!.docs[i][kMessage]);
          }

          // print(snapshot.data!.docs[0]['message']);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text("Chat"),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: MessagesList.length,
                    itemBuilder: (context, index) {
                      return MessagesList[index].id == email
                          ? BubbleChat(
                              message: MessagesList[index].message.toString(),
                            )
                          : BubbleChatForAfriend(
                              message: MessagesList[index].message.toString(),
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),

                  // margin:
                  //     const EdgeInsets.only(right: 10, left: 8, bottom: 8, top: 5),

                  child: TextField(
                    controller: Controller,

                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      _controller.animateTo(
                        //  _controller.position.maxScrollExtent
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                      Controller.clear();
                    },
                    // showCursor: true,

                    decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            messages.add({
                              'message': Controller.text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            _controller.animateTo(
                              0,
                              //  _controller.position.maxScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                            Controller.clear();
                          },
                          child: const Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                const BorderSide(color: kPrimaryColor))),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text("loading");
        }
      },
    );
  }
}
