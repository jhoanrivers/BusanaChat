
import 'package:busana/src/message/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {

  static const String id = "HOME";
  final FirebaseUser user;


  const HomeApp({Key key, this.user}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = new TextEditingController();
  ScrollController scrollController =  new ScrollController();
  bool istextFieldEmpty = true;


  Future<void> callback() async{
    if(messageController.text.length > 0){
      await _firestore.collection('messages').add({
        'text' : messageController.text,
        'from' : widget.user.email,
      });
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeOut);

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40,
            child: Image.asset('assets/logo.png'),
          ),
        ),
        title: Text('Busana Chat'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<DocumentSnapshot> docs = snapshot.data.documents;

                  List<Widget> messages = docs.map((doc) => Messages(
                    from: doc.data['from'],
                    text: doc.data['text'],
                    me: widget.user.email == doc.data['from']
                  )).toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ... messages
                    ],

                  );

                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (text){
                        if(text.isNotEmpty){
                          setState(() {
                            istextFieldEmpty = false;
                          });
                        } else{
                          setState(() {
                            istextFieldEmpty = true;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Messages',
                      ),
                      controller: messageController,
                    ),
                  ),
                  (!istextFieldEmpty)
                      ? IconButton(
                    icon: Icon(Icons.send),
                    iconSize: 30,
                    onPressed: callback,)
                      : IconButton(
                    icon: Icon(Icons.keyboard_voice),
                    tooltip: 'Send',
                    iconSize: 30,
                    onPressed: () {},
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}


