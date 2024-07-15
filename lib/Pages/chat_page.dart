import 'package:firebase/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import 'chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = "ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments.toString();
    //QuerySnapshot snapshot = await messages.orderBy('date', descending: false).snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
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
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index].message.toString(),
                            )
                          : BubbleChatForAfriend(
                              message: messagesList[index].message.toString(),
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),

                  // margin:
                  //     const EdgeInsets.only(right: 10, left: 8, bottom: 8, top: 5),

                  child: TextField(
                    controller: controller,

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
                      controller.clear();
                    },
                    // showCursor: true,

                    decoration: InputDecoration(
                        hintText: "Send Message",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            messages.add({
                              'message': controller.text,
                              kCreatedAt: DateTime.now(),
                              'id': email,
                            });
                            _controller.animateTo(
                              0,
                              //  _controller.position.maxScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                            controller.clear();
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
