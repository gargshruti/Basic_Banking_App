import './makepayment.dart';
import 'package:flutter/material.dart';
import './dbhelper.dart';

class DetailPage extends StatefulWidget {
  final int idx;
  DetailPage(this.idx);

  @override
  State<DetailPage> createState() => _DetailPageState(idx);
}

class _DetailPageState extends State<DetailPage> {
  final dbhelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> data = [];
  int id = 0;
  _DetailPageState(int id) {
    this.id = id;
    _queryspecific(id);
  }

  void _queryspecific(int id) async {
    final allrow = await dbhelper.queryspecific(id);
    data = [];
    allrow.forEach((row) {
      print(row);
      data.add(row);
    });
    data = await data;
    setState(() {});
  }

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Account'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                  onTap: () {},
                  leading: Text('${data[index]["id"]}'),
                  trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Payment(id, data[index]["id"])));
                      },
                      icon: Icon(Icons.arrow_forward_ios_sharp)),
                  title: Text('${data[index]["name"]}'),
                  subtitle: Text('${data[index]["Email"]}'),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
