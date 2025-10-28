import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../transaction_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final transactions = provider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(
            fontFamily: 'Antonio',
          ),
        ),
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text("No transactions yet"),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  child: ListTile(
                    title: Text(
                      tx["title"] ?? "",
                      style: const TextStyle(
                          fontFamily: 'Antonio', fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${tx["category"] ?? ""} •  ${tx["date"] != null ? DateFormat("dd/MM/yyyy HH:mm").format(tx["date"] as DateTime) : "No date"}",
                      style: const TextStyle(
                        fontFamily: 'Antonio',
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "₹${tx["amount"].toString()}",
                          style: TextStyle(
                            fontFamily: 'Antonio',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: tx["type"] == "income"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey.shade700),
                          onPressed: () {
                            provider.removeTransaction(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
