import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String title, date, color, time;
  ListItem(
      {required this.title,
      required this.date,
      required this.time,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              child: Text(
                title != null ? title.substring(0, 1) : "T",
                style: TextStyle(fontSize: 30.0),
              ),
              radius: 30.0,
            ),
            Padding(padding: EdgeInsets.only(right: 10.0)),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title ?? "Title Not Available",
                      style: TextStyle(fontSize: 20.0),
                      softWrap: true,
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Date : ${date ?? "NA"}"),
                        ),
                        Expanded(
                          child: Text("Time : ${time ?? "NA"}"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
