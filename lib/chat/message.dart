import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  Future<User?> data() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {

    return  FutureBuilder(
        future: data(),
      builder: (ctx, AsyncSnapshot futureSnapshot){
        if(futureSnapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
          'createdAt',
          descending: true
      ).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),
          );
        }
        final chatDocs=chatSnapshot.data!.docs;
                return ListView.builder(
              reverse: true,
              itemCount: chatSnapshot.data!.docs.length,
              itemBuilder: (ctx, index) =>
                  MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['username'],
                      chatDocs[index]['userImage'],
                      chatDocs[index]['userId'] ==
                          futureSnapshot.data.uid,
                    key: ValueKey(chatDocs[index].id),
                  ),
            );
          }
        );
      },

    );
  }
}
