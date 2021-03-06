import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {

  MessageBubble(
      this.message,
      this.username,
      this.userImage,
      this.isMe,
      {required this.key}
      );
  final Key key;
  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
         Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft:  !isMe ? const Radius.circular(0) : const Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
            ),
            width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            horizontal: 16,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 14,
            horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
              //  FutureBuilder(
                  // future: FirebaseFirestore
                  //     .instance.collection('users').doc(userId).get(),
                  // builder: (context, snapshot) {
                  //   if(snapshot.connectionState == ConnectionState){
                  //     return Text('loading....');
                  //   }
                   // return
                Text(
                  username,
                     // snapshot.data['username'],
                      style: TextStyle(fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color,),
                      ),
                Text(
                  message,
                  style: TextStyle(
                  color: isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color,

                ),
               textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            ),
          ),
        ],
      ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
            right: isMe ? 120 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage,),
            )
        ),

      ],
      overflow: Overflow.visible,
    );
  }
}
