import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return
        /*for long lists use list view builder*/
        transactions.length == 0
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'NO TRANSACTIONS ADDED YET!!',
                      style: TextStyle(
                        fontFamily: 'QuickSand-Bold',
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20), //sized box can also be used
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ),
                      height: constraints.maxHeight * 0.6,
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (tx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(fontFamily: 'OpenSans'),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: mediaquery.size.width > 460
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).primaryColor,
                              onPressed: () => deletetx(transactions[index].id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => deletetx(transactions[index].id),
                            ),
                    ),
                  );
                });
  }
}
