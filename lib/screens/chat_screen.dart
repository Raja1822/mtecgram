// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseDatabase _database = FirebaseDatabase.instance;
//   final TextEditingController _messageController = TextEditingController();
//   User? _user;

//   @override
//   void initState() {
//     super.initState();
//     _auth.authStateChanges().listen((user) {
//       setState(() {
//         _user = user;
//       });
//     });
//   }

//   void _sendMessage() {
//     final message = _messageController.text;
//     if (message.isNotEmpty) {
//       final ref = _database.reference().child('messages');
//       ref.push().set({
//         'text': message,
//         'sender': _user?.displayName ?? 'Anonymous',
//       });
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat App'),
//         actions: <Widget>[
//           if (_user != null)
//             IconButton(
//               icon: Icon(Icons.logout),
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//             ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: StreamBuilder(
//               stream: _database.ref().child('messages').onValue,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 final messagesMap =
//                     Map<String, dynamic>.from(snap.data!.snapshot.value);
//                 final messages = messagesMap.values.toList();
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     return ListTile(
//                       title: Text(message['sender']),
//                       subtitle: Text(message['text']),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Enter a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }