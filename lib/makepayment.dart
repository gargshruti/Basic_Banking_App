import 'package:bank_project/main.dart';

import './dbhelper.dart';
import './transactionpage.dart';
import './transactiondetails.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  final int idx1;
  final int idx2;
  Payment(this.idx1, this.idx2);
  @override
  _PaymentState createState() => _PaymentState(idx1, idx2);
}

class _PaymentState extends State<Payment> {
  int idx1 = 0;
  int idx2 = 0;

  int max_transfer = 0;
  int new_amount = 0;
  List<Map<String, dynamic>> data = [];

  _PaymentState(idx1, idx2) {
    this.idx1 = idx1;
    this.idx2 = idx2;
    _amountDetails(idx1);
  }

  final dbhelper = DatabaseHelper.instance;
  final _amountController = TextEditingController();

  String from_customer = "";
  String to_customer = "";

  _amountDetails(int id) async {
    List<Map<String, dynamic>> customerlist = await dbhelper.tqueryspecific(id);
    data = [];
    data = await customerlist;
    int ans = data[0]["amount"];
    from_customer = data[0]["name"];
    max_transfer = await ans;
    List<Map<String, dynamic>> newlist = await dbhelper.tqueryspecific(idx2);
    data = [];
    data = await newlist;
    ans = data[0]["amount"];
    new_amount = await ans;
    to_customer = data[0]["name"];
    setState(() {});
  }

  bool success = true;

  int enteredAmount = 0;
  void transfer_amount() {
    enteredAmount = int.parse(_amountController.text);
    if (max_transfer < enteredAmount || enteredAmount < 500) {
      print("Errrrrrrrrrooooooooorrrrrrrrr");
      success = false;
      setState(() {});
    } else {
      dbhelper.update(idx1, max_transfer - enteredAmount);
      dbhelper.update(idx2, new_amount + enteredAmount);
      dbhelper.tinsert({
        "fromId": idx1,
        "toId": idx2,
        "amount": enteredAmount,
        "fromName": from_customer,
        "toName": to_customer
      });
      dbhelper.tqueryspecific(idx1);
      success = true;
      setState(() {});
    }
  }

  String setnames() {
    from_customer = from_customer;
    to_customer = to_customer;
    print('From: $from_customer To: $to_customer');
    return 'From: $from_customer To: $to_customer';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer Amount'),
      ),
      body: Container(
          child: Card(
              child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: Text(setnames()),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Transaction Amount',
              hintText: 'Enter Amount',
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: Text('Submit'),
          // )
          !success
              ? ListTile(
                  title: Text(
                    'Transfer Amount cannot exceed $max_transfer.',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : ListTile(
                  title: Text(
                    'Amount must be greater than 500',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
          ElevatedButton(
            child: Text('Transfer'),
            onPressed: () {
              transfer_amount();
              if (success)
                Navigator.pushAndRemoveUntil(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()),
                    (Route<dynamic> route) => false);
            },
          )
        ],
      ))),
    );
  }
}
