import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ryc_expenses_responsive/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) onRemove;

  TransactionList(
    this.transactions,
    this.onRemove, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (_, constraints) {
              return Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'Nenhuma Transação Cadastrada',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.01),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (_, _index) {
                final Transaction transaction = transactions[_index];

                return Card(
                  elevation: 5.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 5.0,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('R\$${transaction.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(transaction.date),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => onRemove(transaction.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
