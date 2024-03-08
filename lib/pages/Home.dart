import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/list_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> items = [];
  List<ListItem> li = [];
  List<String> AllKeys = [];
  late String item;

  @override
  void initState() {
    loadData();
  }

  FirebaseUser user;
  DatabaseReference ref;

  void loadData() async {
    items = [];
    user = await FirebaseAuth.instance.currentUser!;
    ref = FirebaseDatabase.instance.reference();
    ref.child('to-do/${user.uid}').onValue.listen((evt) {
      li = [];
      AllKeys = [];
      if (evt.snapshot.value == null) {
        showInSnackBar('No Wiork to Show');
        return;
      }
      DataSnapshot data = evt.snapshot;

      var keys = data.value.keys;
      var todo = data.value;
      for (var key in keys) {
        li.add(ListItem(
            title: '${todo[key]['name'] ?? 'NO Title'}',
            date: '${todo[key]['date']}',
            time: '${todo[key]['time']}', color: 'Colors.blue',));
        print(key.toString());
        AllKeys.add(key);
      }
      setState(() {});
    });
  }

  void showInSnackBar(String value) {
    // _scaffoldKey.currentState
    //     .showSnackBar(    SnackBar(content:     Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('TODO App'),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                value: 'github',
                child: Text('Github'),
              ),
              const PopupMenuItem<String>(child: Text('About'), value: 'about'),
              const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout')),
            ],
            onSelected: (val) {
              switch (val) {
                case 'logout':
                  FirebaseAuth.instance
                      .signOut()
                      .then((data) => Navigator.pop(context));
              }
            },
          )
        ],
      ),
      body: Center(
        child: li.isEmpty
            ? Text(
                'No work to Do',
                style: Theme.of(context).textTheme.displayLarge,
              )
            : showUI(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/Add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget showUI() {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: ObjectKey(li[index]),
          onDismissed: (direction) {
            print('${index}');
            print('Keys ${AllKeys[index].toString()}');
            setState(() {
              li.removeAt(index);
            });
            ref.child('to-do/${user.uid}/${AllKeys[index]}').remove();
            AllKeys.removeAt(index);
          },
          background: Container(
            color: Colors.red,
          ),
          secondaryBackground: Container(
            color: Colors.red,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: li[index],
          ),
        );
      },
    );
  }
}
