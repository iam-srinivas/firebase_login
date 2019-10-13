import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool isSignedIn = false;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/LoginPage");
      }
    });
  }

  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: !isSignedIn
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        "Hello ,${user.displayName}, You are logged in as ${user.email}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/FolkList");
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'View List of Students',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                        )),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: signOut,
                        color: Colors.blue,
                        child: Text(
                          'SignOut',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
