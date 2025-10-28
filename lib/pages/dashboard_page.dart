import 'package:finance_tracker/category_card.dart';
import 'package:finance_tracker/pages/new_transaction_page.dart';
import 'package:finance_tracker/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SafeArea(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Dashboard',
                style: TextStyle(
                    fontFamily: 'Antonio',
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                              fontFamily: 'Antonio',
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${provider.totalBalance} ₹",
                          style: const TextStyle(
                              fontFamily: 'Antonio',
                              fontSize: 25,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Column(
              children: [
                CategoryCard(
                  title: 'Income',
                  amount: provider.totalIncome,
                ),
                const SizedBox(
                  height: 10,
                ),
                CategoryCard(
                  title: 'Expence',
                  amount: provider.totalExpense,
                ),
              ],
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NewTransactionPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            'Add new transaction',
                            style: TextStyle(
                                fontFamily: 'Antonio',
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.add,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Categories',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Center(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Expense',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // CategoryCard(
                      //   title: 'Food',
                      //   amount: provider.food.toInt(),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // CategoryCard(
                      //   title: 'Shopping',
                      //   amount: provider.shopping.toInt(),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CategoryCard(
                      //   title: 'Travel',
                      //   amount: provider.travel.toInt(),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CategoryCard(
                      //   title: 'Health',
                      //   amount: provider.health.toInt(),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CategoryCard(
                      //   title: 'Others',
                      //   amount: provider.othersExpense.toInt(),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.categoryAmountExpense.length,
                        itemBuilder: (context, index) {
                          final amount = provider.categoryAmountExpense[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index < 3
                                ? GestureDetector(
                                    onLongPress: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "defualt values can't be deleted",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary))));
                                    },
                                    child: CategoryCard(
                                        title: amount["category"],
                                        amount: amount["amount"]),
                                  )
                                : GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Do you want to delete this category"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      provider
                                                          .removeExpCat(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Delete",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.red))),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: Colors.blue),
                                                    ))
                                              ],
                                            );
                                          });
                                    },
                                    child: CategoryCard(
                                      amount: amount["amount"],
                                      title: provider.categoriesExpense[index],
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Text('Income',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    // CategoryCard(
                    //   title: 'Salary',
                    //   amount: provider.salary.toInt(),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CategoryCard(
                    //   title: 'Interest',
                    //   amount: provider.interest.toInt(),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CategoryCard(
                    //   title: 'Incentives',
                    //   amount: provider.incentives.toInt(),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // CategoryCard(
                    //   title: 'Others',
                    //   amount: provider.othersIncome.toInt(),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.categoryAmountIncome.length,
                        itemBuilder: (context, index) {
                          final amount = provider.categoryAmountIncome[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: index < 2
                                ? GestureDetector(
                                    onLongPress: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                        "defualt values can't be deleted",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      )));
                                    },
                                    child: CategoryCard(
                                        title: amount["category"],
                                        amount: amount["amount"]),
                                  )
                                : GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Do you want to delete this category"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      provider
                                                          .removeIncCat(index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Cancel",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.blue)))
                                              ],
                                            );
                                          });
                                    },
                                    child: CategoryCard(
                                        title: provider.categoriesIncome[index],
                                        amount: amount["amount"]),
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
