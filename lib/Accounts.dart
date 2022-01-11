import './dbhelper.dart';
import 'package:flutter/material.dart';
import './transactionpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbhelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> data = [];

  _HomePageState() {
    // dbhelper.insert({
    //   DatabaseHelper.columnId: 10,
    //   DatabaseHelper.columnName: "Charlie9",
    //   DatabaseHelper.columnEmail: "charlie9982@gmail.com",
    //   DatabaseHelper.columnAmount: 12566,
    // });
    //_insertdata();
    //dbhelper.UpdateTable(10);
    _queryall();
  }

  void _insertdata() async {
    List<Map<String, dynamic>> row = [
      {
        DatabaseHelper.columnId: 1,
        DatabaseHelper.columnName: "Alexa",
        DatabaseHelper.columnEmail: "alexa982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 2,
        DatabaseHelper.columnName: "Jack",
        DatabaseHelper.columnEmail: "jack1982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 3,
        DatabaseHelper.columnName: "Monica",
        DatabaseHelper.columnEmail: "monica2982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 4,
        DatabaseHelper.columnName: "Rachel",
        DatabaseHelper.columnEmail: "rachel982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 5,
        DatabaseHelper.columnName: "Henry",
        DatabaseHelper.columnEmail: "henry982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 6,
        DatabaseHelper.columnName: "Joe",
        DatabaseHelper.columnEmail: "joe5982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 7,
        DatabaseHelper.columnName: "Rubina",
        DatabaseHelper.columnEmail: "rubina6982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 8,
        DatabaseHelper.columnName: "George",
        DatabaseHelper.columnEmail: "george982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 9,
        DatabaseHelper.columnName: "Maximilian",
        DatabaseHelper.columnEmail: "max8982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      },
      {
        DatabaseHelper.columnId: 10,
        DatabaseHelper.columnName: "John",
        DatabaseHelper.columnEmail: "john982@gmail.com",
        DatabaseHelper.columnAmount: 250000,
      }
    ];
    for (int i = 0; i < 10; i++) {
      final id = await dbhelper.insert(row[i]);
      print(id);
    }
    print(dbhelper.queryAllRows());
  }

  void _queryall() async {
    final allrow = await dbhelper.queryAllRows();
    data = [];
    allrow.forEach((row) {
      print(row);
      data.add(row);
    });
    data = await data;
    setState(() {});
  }

  // ignore: unused_element
  // void _queryspecific() async {
  //   var allrows = await dbhelper.queryspecific(500);
  //   print(allrows);
  // }

  // void _delete() async {
  //   var id = await dbhelper.delete(1);
  //   print(id);
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('From Account'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(data[idx]["id"])));
                  },
                  leading: Text('${data[idx]["id"]}'),
                  trailing: Text('Rs.${data[idx]["amount"]}'),
                  title: Text('${data[idx]["name"]}'),
                  subtitle: Text('${data[idx]["Email"]}'),
                ),
              );
            }),
      ),
    );
  }
}
