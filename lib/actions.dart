import 'package:flutter/material.dart';

class ActionPage extends StatefulWidget {
  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  onPressed: () {},
                  child: Text('Assign'),
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                  onPressed: () {},
                  child: Text('Report'),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
