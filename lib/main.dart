import 'package:flutter/material.dart';

import './models/transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/charts.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Calculator',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          textTheme: TextTheme(
              headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transactions> transactions = [
    Transactions(
        id: "1",
        item: "Car EMI",
        price: 93.0,
        dateTime: DateTime.now().subtract(Duration(days: 5))),
    Transactions(
        id: "2",
        item: "Credit car bill",
        price: 15.0,
        dateTime: DateTime.now().subtract(Duration(days: 4))),
    Transactions(
        id: "3", item: "Current bill", price: 50.0, dateTime: DateTime.now()),
  ];

  bool _ShowChart = false;

  void addTransactionToList(
      String newItemToAdd, double newPriceForItemAdded, DateTime _pickedDate) {
    var newTrx = Transactions(
        id: DateTime.now().toString(),
        item: newItemToAdd,
        price: newPriceForItemAdded,
        dateTime: _pickedDate);

    setState(() {
      transactions.add(newTrx);
    });
  }

  showAddTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactionsEntries(addTransactionToList),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Transactions> get recentTransactionsForChart {
    print(transactions);
    return transactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteItemsInList(String deleteId) {
    setState(() {
      transactions.removeWhere(((element) => element.id == deleteId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Expense Calculator'),
      actions: [
        IconButton(
            onPressed: (() => showAddTransactionModal(context)),
            icon: Icon(Icons.add))
      ],
    );
    final chartWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.8,
        child: TransactionList(transactions, deleteItemsInList));
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(
                        value: _ShowChart,
                        onChanged: (val) {
                          setState(() {
                            _ShowChart = val;
                          });
                        })
                  ],
                ),
              if (isLandScape)
                _ShowChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.5,
                        child: Charts(recentTransactionsForChart))
                    : chartWidget,
              if (!isLandScape)
                Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.2,
                    child: Charts(recentTransactionsForChart)),
              if (!isLandScape) chartWidget
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() => showAddTransactionModal(context)),
        ));
  }
}
