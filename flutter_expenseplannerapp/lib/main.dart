import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_expenseplannerapp/widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'OpenSans',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final List<Transaction> _transactions = [
    /*Transaction(
      amount: 69,
      date: DateTime.now(),
      id: 't1',
      title: 'New Shoes',
    ),
    Transaction(
      amount: 63,
      date: DateTime.now(),
      id: 't2',
      title: 'Weekly Groceries',
    ),*/
  ];
  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(
          days: 7,
        ),
      ));
    }).toList();
  }

  void _addnewTransaction(String title, double amount, DateTime chosendate) {
    final newtx = Transaction(
      amount: amount,
      date: chosendate,
      id: DateTime.now().toString(),
      title: title,
    );

    setState(() {
      _transactions.add(newtx);
    });
  }

  @override
  void _startaddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addnewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _transactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaquery,
    AppBar appBar,
    Widget tlistwidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('SHOW CHART',
              style: TextStyle(
                fontFamily: 'OpenSans',
              )),
          Switch.adaptive(
            activeColor: Theme.of(context).primaryColorDark,
            value: _showChart,
            onChanged: (val) {
              _showChart = val;
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaquery.size.height -
                      appBar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : tlistwidget
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaquery, AppBar appBar, Widget tlistwidget) {
    return [
      Container(
        height: (mediaquery.size.height -
                appBar.preferredSize.height -
                mediaquery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      tlistwidget
    ];
  }

  //String titleinput;
  //String amountinput;
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startaddnewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal expenses',
              style: TextStyle(
                fontFamily: 'QuickSand',
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startaddnewTransaction(context),
              )
            ],
          );
    final tlistwidget = Container(
      height: (mediaquery.size.height -
              appBar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTransactions),
    );
    final scaffold = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                mediaquery,
                appBar,
                tlistwidget,
              ),
            if (!isLandscape)
              ..._buildPotraitContent(
                mediaquery,
                appBar,
                tlistwidget,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: scaffold,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: scaffold,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : (FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startaddnewTransaction(context),
                  )),
          );
  }
}
