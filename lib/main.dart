import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planner/models/transactions.dart';
import 'package:planner/widgets/chart.dart';
import 'package:planner/widgets/newTranactions.dart';
import 'package:planner/widgets/transactions_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addNewTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      DateTime: dateTime,
    );
    setState(() {
      _transactionsList.add(newTx);
    });
  }

  bool _showBar = false;

  void _deleteTransaction(String id) {
    setState(() {
      _transactionsList.removeWhere((element) => element.id == id);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: NewTranactions(_addNewTransaction),
        );
      },
    );
  }

  final List<Transactions> _transactionsList = [];
  List<Transactions> get _recentTransactions {
    return _transactionsList.where((element) {
      return element.DateTime.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: Text("Personal Expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            backwardsCompatibility: false,
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.black),
            title: Text("Expense Planner"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              )
            ],
          );

    final chartWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .3,
      child: Chart(_recentTransactions),
    );

    final tranactionListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          .7,
      child: TranactionsList(_transactionsList, _deleteTransaction),
    );

    final swithBar = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "show bar",
          style: Theme.of(context).textTheme.title,
        ),
        Switch.adaptive(
          value: _showBar,
          activeColor: Colors.amber,
          onChanged: (val) {
            setState(
              () {
                _showBar = val;
              },
            );
          },
        ),
      ],
    );

    final scaffoldBody = Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (isLandScape) swithBar,
              if (isLandScape)
                _showBar ? chartWidget : Text("show bar is closed"),
              if (isLandScape) tranactionListWidget,
              if (!isLandScape) chartWidget,
              if (!isLandScape) tranactionListWidget,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => _startNewTransaction(context),
              child: Icon(
                Icons.add,
                color: Colors.amber,
              ),
            ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: scaffoldBody,
            navigationBar: appBar,
          )
        : scaffoldBody;
  }
}
