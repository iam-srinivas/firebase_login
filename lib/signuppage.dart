import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  navigateToLogin() {
    Navigator.pushNamed(context, "/LoginPage");
  }

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if (user != null) {
          UserUpdateInfo updateUser = UserUpdateInfo();
          updateUser.displayName = _name;
          user.updateProfile(updateUser);
        }
      } catch (e) {
        showError(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(60),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an Name';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onSaved: (input) => _name = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an Email';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should Be atleast 6 Characters';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: signup,
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          child: Text(
                            'Already a user',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                          onTap: navigateToLogin,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
