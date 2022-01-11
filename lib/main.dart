import './dbhelper.dart';
import './transactionpage.dart';
import 'package:flutter/material.dart';
import './Accounts.dart';

void main() {
  runApp(MyApp());
  //WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to the Your Bank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbhelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> tdata = [];

  _MyHomePageState() {
    // dbhelper.insert({
    //   DatabaseHelper.columnId: 10,
    //   DatabaseHelper.columnName: "Charlie9",
    //   DatabaseHelper.columnEmail: "charlie9982@gmail.com",
    //   DatabaseHelper.columnAmount: 12566,
    // });
    //_tinsertdata();
    //dbhelper.deletetransactions();
    //dbhelper.tupdate();
    _tqueryall();
  }
  void _delete(int id) async {
    await dbhelper.deletetransactions(tdata[id]);
  }

  void _tinsertdata() async {
    List<Map<String, dynamic>> row = [
      // {
      //   DatabaseHelper.fromId: 10,
      //   DatabaseHelper.toId: 4,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 3,
      //   DatabaseHelper.toId: 10,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 9,
      //   DatabaseHelper.toId: 1,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 5,
      //   DatabaseHelper.toId: 4,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 7,
      //   DatabaseHelper.toId: 2,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 4,
      //   DatabaseHelper.toId: 8,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 9,
      //   DatabaseHelper.toId: 2,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 5,
      //   DatabaseHelper.toId: 9,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 1,
      //   DatabaseHelper.toId: 7,
      //   DatabaseHelper.columnAmount: 12566,
      // },
      // {
      //   DatabaseHelper.fromId: 6,
      //   DatabaseHelper.toId: 3,
      //   DatabaseHelper.columnAmount: 12566,
      // }
    ];
    for (int i = 0; i < 10; i++) {
      final id = await dbhelper.tinsert(row[i]);
      print(id);
    }
    print(dbhelper.tqueryAllRows());
  }

  void _tqueryall() async {
    final allrow = await dbhelper.tqueryAllRows();
    tdata = [];
    allrow.forEach((row) {
      print(row);
      tdata.add(row);
    });
    tdata = await tdata;
    tdata = List.from(tdata.reversed);
    print(tdata.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: tdata.length,
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 10,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: ListTile(
                  title: Text('From: ${tdata[idx]["fromName"]}'),
                  subtitle: Text('To: ${tdata[idx]["toName"]}'),
                  trailing: Text('Rs.${tdata[idx]["amount"]}'),
                  leading: Text('Sent'),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// @override
// Widget build(BuildContext context) {
//   throw UnimplementedError();
// }
