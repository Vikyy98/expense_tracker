import 'package:expense_tracker/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransaction;
  final Function deleteTransactionList;
  TransactionList(this.userTransaction, this.deleteTransactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 543,
      child: userTransaction.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text("No items added",
                      style: Theme.of(context).textTheme.headline6),
                  Container(
                      height: constraints.maxHeight * 0.7,
                      margin: EdgeInsets.only(top: 10),
                      child: Image.network('https://picsum.photos/250?image=9'))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: FittedBox(
                          child: Text(
                            '\$${userTransaction[index].price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      userTransaction[index].item,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(DateFormat.yMMMMd()
                        .format(userTransaction[index].dateTime)),
                    trailing: MediaQuery.of(context).size.width > 420
                        ? TextButton.icon(
                            onPressed: () => deleteTransactionList(
                                userTransaction[index].id),
                            icon: Icon(Icons.delete,
                                color: Theme.of(context).errorColor),
                            label: Text(
                              'Delete',
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            ))
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Theme.of(context).errorColor,
                            ),
                            //color: Colors.red,
                            onPressed: () => deleteTransactionList(
                                userTransaction[index].id),
                          ),
                  ),
                );
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
