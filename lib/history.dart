import 'package:flutter/material.dart';

import 'data/database.dart';
import 'data/model.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
  List<HistoryData> items = new List();
  DatabaseHelper db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();

    db.queryAll().then((histories) {
      setState(() {
        histories.forEach((history) {
          items.add(HistoryData.fromMap(history));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histories"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(8.0),
            itemBuilder: (context, position) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Divider(height: 2.5),
                  ListTile(
                      title: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '${items[position].expression}',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.deepOrangeAccent,
                                wordSpacing: -0.5,
                                letterSpacing: -0.5),
                          )),
                      subtitle: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('= ${items[position].result}',
                            textAlign: TextAlign.right,
                            style: new TextStyle(fontSize: 15.0)),
                      )),
                ],
              );
            }),
      ),
    );
  }
}
