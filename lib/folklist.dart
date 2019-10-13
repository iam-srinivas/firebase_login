import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'actions.dart';

class FolkList extends StatefulWidget {
  @override
  _FolkListState createState() => _FolkListState();
}

class _FolkListState extends State<FolkList> {
  Firestore db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Folk List'),
        ),
        body: Container(
          child: StreamBuilder(
            stream: db.collection('folks').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    title: Text(snapshot.data.documents[index]['name']),
                    subtitle:
                        Text(snapshot.data.documents[index]['uId'].toString()),
                    trailing: Text(snapshot.data.documents[index]['email']),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/a");
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => ActionPage(),
      },
    );
  }
}
