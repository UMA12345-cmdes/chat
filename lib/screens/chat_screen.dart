import 'package:firebase_messaging/firebase_messaging.dart';
import '../chat/new_message.dart';
import '../chat/message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

 @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
       print(message);
      return;
    });
    fbm.subscribeToTopic('chat');
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter chat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color,),
              items: [
                DropdownMenuItem(
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 8,),
                    Text('Logout')
                  ],
                ),
                  value: 'logout',
                ),
              ], onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
          },
          ),
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(child: Message(),
          ),
          NewMessage(),
        ],
      ),
      // StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/cEBlvhvMZNpCHRAyq5Wa/mona')
      //       .snapshots(),
      //   builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //       final docs = streamSnapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: docs.length,
      //         itemBuilder: (ctx, index) =>
      //             Container(
      //               padding: const EdgeInsets.all(8),
      //               child: Text(docs[index]['text']),
      //             ),
      //       );
      //
      //   },
      // ),

    );
  }

  requestNotifictionPermissions() {}
}





