import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance
            .collection('/chats/fZLwivoOUnPMpzZ4qtnO/message').snapshots(),
          builder: (ctx, streamSnapshot) {
            // print("rahul ${streamSnapshot.data}");

          if(streamSnapshot.connectionState == ConnectionState.active){
            print("rahul ${streamSnapshot.data.docs!}");
            return Center(child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(

            itemCount: 12, //streamSnapshot.hasData.,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text('this works'),
              ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          // listen(data) {
          // //  print(data.documents[0]['text']);
          //   data.documents.forEach((document) {
          //     print(document['text']);
          //   });
          // };
              },
      ),
    );
  }
}