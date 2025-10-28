import 'package:finance_tracker/pages/sub%20pages/expense_page.dart';
import 'package:finance_tracker/pages/sub%20pages/income_page.dart';
import 'package:flutter/material.dart';

class NewTransactionPage extends StatelessWidget {
  const NewTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
              labelColor: Colors.blue,
              tabs: const [
                Tab(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Expense',
                      style: TextStyle(
                        fontFamily: 'Antonio',
                      ),
                    ),
                  ),
                ),
                Tab(
                    child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Income',
                    style: TextStyle(
                      fontFamily: 'Antonio',
                    ),
                  ),
                ))
              ]),
        ),
        body: const TabBarView(children: <Widget>[
          Card(
            child: ExpensePage(),
          ),
          Card(
            child: IncomePage(),
          )
        ]),
      ),
    );
  }
}
