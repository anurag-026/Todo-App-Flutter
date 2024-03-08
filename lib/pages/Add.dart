import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final GlobalKey<ScaffoldState> _scaffoldKey =    GlobalKey<ScaffoldState>();
  DateTime date =    DateTime.now();
  TimeOfDay time =    TimeOfDay.now();
  TextEditingController work =    TextEditingController();
  late DatabaseReference ref;
  FirebaseUser user;

  Future<Null> datep() async {
    final DateTime? pick = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate:    DateTime(2018),
      lastDate:    DateTime(2022),
    );
    if (pick != null) {
      date = pick;
      print(pick.toString());
      setState(() {});
    }
  }

  Future<Null> timep() async {
    final TimeOfDay pick = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (pick != null) {
      time = pick;
      print(pick.toString());
      setState(() {});
    }
  }

  @override
  void initState() {
    initInstance();
  }

  void initInstance() async {
    ref =    FirebaseDatabase().reference();
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar:  AppBar(
        title: const  Text('Add Work Todo'),
      ),
      body:  Container(
        margin: const  EdgeInsets.all(10.0),
        child:    Card(
          child:    ListView(
            padding:  const  EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 15.0,
            ),
            children: <Widget>[
              const Center(
                child:    Text(
                  'Add Some work',
                  style:    TextStyle(fontSize: 28.0),
                ),
              ),
              const Padding(padding:    EdgeInsets.all(10.0)),
                 TextField(
                controller: work,
                decoration: const   InputDecoration(hintText: 'Enter Work Name'),
              ),
              const Padding(padding:    EdgeInsets.all(10.0)),
                 Row(
                children: <Widget>[
                     Expanded(
                      child:    Text(
                    'Date : ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                     Expanded(
                      child:    TextButton(
                    onPressed: datep,
                    child:    Text("${date.day.toString()}/${date.month
                            .toString()}/${date
                            .year
                            .toString()}"),
                  )),
                ],
              ),
                 Padding(padding:    EdgeInsets.all(10.0)),
                 Row(
                children: <Widget>[
                     Expanded(
                      child:    Text(
                    'Time : ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  )),
                     Expanded(
                      child:    FlatButton(
                    onPressed: timep,
                    child:    Text("${time.hour}:${time.minute}"),
                  ))
                ],
              ),
                 Padding(padding:    EdgeInsets.all(10.0)),
                 RaisedButton(
                  padding:    EdgeInsets.all(10.0),
                  onPressed: saveToFirebase,
                  child:    Text(
                    'Add',
                    style: Theme.of(context).textTheme.title,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(   SnackBar(content:    Text(value)));
  }

  void saveToFirebase() {
    if (work.text.length < 3) {
      showInSnackBar('Write something longer than 3 char');
      return;
    }
    Object data = {
      'name': work.text,
      'date': '${date.day}/${date.month}/${date.year}',
      'time': '${time.hour}:${time.minute}',
      'status': '1'
    };
    work.clear();
    ref.child('/to-do/${user.uid}').push().set(data);
  }
}
