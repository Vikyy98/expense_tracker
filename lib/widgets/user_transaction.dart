// import 'package:flutter/material.dart';
// import './new_transaction.dart';
// import './transaction_list.dart';
// import '../models/transactions.dart';

// class UserTransactions extends StatefulWidget {
//   @override
//   State<UserTransactions> createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {
//   List<Transactions> transactions = [
//     Transactions(
//         id: "1", item: "Car EMI", price: 14500, dateTime: DateTime.now()),
//     Transactions(
//         id: "2",
//         item: "Credit car bill",
//         price: 2501,
//         dateTime: DateTime.now()),
//     Transactions(
//         id: "3", item: "Current bill", price: 1500, dateTime: DateTime.now()),
//   ];

//   void addTransactionToList(String newItemToAdd, double newPriceForItemAdded) {
//     var newTrx = Transactions(
//         id: DateTime.now().toString(),
//         item: newItemToAdd,
//         price: newPriceForItemAdded,
//         dateTime: DateTime.now());

//     setState(() {
//       transactions.add(newTrx);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // NewTransactionsEntries(addTransactionToList),
//         TransactionList(transactions)
//       ],
//     );
//   }
// }
