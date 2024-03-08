import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Theme/Theme.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const String logo =
      'https://seeklogo.com/images/A/angular-logo-B76B1CDE98-seeklogo.com.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(child: LoginUI(context)),
    );
  }

  void showInSnackBar(String value) {
    //_scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  LoginVerify() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (Validate) {
      auth
          .signInWithEmailAndPassword(
              email: controllerEmail.text, password: controllerPassword.text)
          .then((user) {
        showInSnackBar('Login Success');
        Navigator.popAndPushNamed(context, '/Home');
      }).catchError(
        (onError) => showInSnackBar(onError.toString()),
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

  void checkLogin() {
    FirebaseAuth.instance.currentUser!.then((user) {
      if (user != null) if (!user.isAnonymous) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/Home');
      }
    });
  }

  @override
  void initState() {
    checkLogin();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
  }

  Widget LoginUI(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.gradient,
      ),
      height: screenSize.height,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding:const EdgeInsets.only(top: 70.0, bottom: 40.0),
            child: Center(
              child: Image.network(
                logo,
                height: 120.0,
                width: 120.0,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
          Card(
            elevation: 8.0,
            child: Container(
              padding:const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40.0, color: Color(0xFF3366AA)),
                  ),
                  TextField(
                    controller: controllerEmail,
                    maxLines: 1,
                    maxLength: 32,
                    onSubmitted: (String) =>
                        FocusScope.of(context).requestFocus(myFocusNode),
                    decoration:const InputDecoration(hintText: 'E-mail ID'),
                  ),
                  TextField(
                    controller: controllerPassword,
                    maxLines: 1,
                    maxLength: 32,
                    focusNode: myFocusNode,
                    obscureText: true,
                    decoration:const InputDecoration(hintText: 'Password'),
                  ),
                  Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: ElevatedButton(
                            onPressed: () => LoginVerify(),
                            child:const Text(
                              'Login',
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 40.0)),
          const Text(
            'If you are     here then',
            style: TextStyle(color: Colors.white),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed("/Register"),
            child: const Text(
              'Click here to Register',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
