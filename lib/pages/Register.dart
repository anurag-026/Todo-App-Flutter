import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Theme/Theme.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  static const String logo =
      'https://seeklogo.com/images/A/angular-logo-B76B1CDE98-seeklogo.com.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(child: RegisterUI(context)),
    );
  }

  void showInSnackBar(String value) {
    //_scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(value)));
  }

  Register() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (Validate) {
      auth
          .createUserWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text)
          .then((user) {
        showInSnackBar('Register Successfully !');
        Navigator.popAndPushNamed(context, 'Home');
      }).catchError(
        (onError) => showInSnackBar('Something went Wrong !'),
      );
    }
  }

  bool get Validate {
    String email = controllerEmail.text;
    String password = controllerPassword.text;
    if (email.length != 0 || password.length != 0) {
      return true;
    } else {
      showInSnackBar('Email and Password Field are Required !');
      return false;
    }
  }

  final FocusNode myFocusNode = FocusNode();

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget RegisterUI(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.gradient,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: screenSize.height,
      child: Column(
        children: <Widget>[
          Padding(
            child: Center(
              child: Image.network(
                logo,
                height: 120.0,
                width: 120.0,
              ),
            ),
            padding: EdgeInsets.only(top: 70.0, bottom: 40.0),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
          Card(
            elevation: 8.0,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Register',
                    style: TextStyle(fontSize: 40.0, color: Color(0xFF3366AA)),
                  ),
                  TextField(
                    controller: controllerEmail,
                    maxLines: 1,
                    maxLength: 32,
                    onSubmitted: (String) =>
                        FocusScope.of(context).requestFocus(myFocusNode),
                    decoration: InputDecoration(hintText: 'E-mail ID'),
                  ),
                  TextField(
                    controller: controllerPassword,
                    maxLines: 1,
                    maxLength: 32,
                    focusNode: myFocusNode,
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                  TextButton(
                    onPressed: () => Register(),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
          Text('Already Registered'),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Click here to Login'),
          ),
        ],
      ),
    );
  }
}
