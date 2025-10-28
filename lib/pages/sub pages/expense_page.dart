import 'package:finance_tracker/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _newCatController = TextEditingController();

  // final List<String> categories = [
  //   "Food",
  //   "Travel",
  //   "Shopping",
  //   "Health",
  //   "Others"
  // ];

  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    final List<String> categories =
        Provider.of<TransactionProvider>(context).categoriesExpense;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Amount',
                  style: TextStyle(
                      fontFamily: 'Antonio',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Card(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Enter amount",
                    hintStyle: TextStyle(
                      fontFamily: 'Antonio',
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Title',
                  style: TextStyle(
                      fontFamily: 'Antonio',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Card(
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Enter title",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Category',
                  style: TextStyle(
                      fontFamily: 'Antonio',
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                dropdownColor: Theme.of(context).colorScheme.primary,
                hint: const Text(
                  "Select Category",
                  style: TextStyle(
                    fontFamily: 'Antonio',
                  ),
                ),
                value: selectedCategory,
                isExpanded: true,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue;
                  });
                },
              ),
              const SizedBox(height: 7),

              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary),
                      autofocus: true,
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: const Text("New category"),
                                content: TextField(
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(12),
                                      hintText: "Enter new category name",
                                      border: OutlineInputBorder()),
                                  controller: _newCatController,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        final newCategory =
                                            _newCatController.text.trim();
                                        final normalizedNew =
                                            newCategory.toLowerCase();
                                        final normalizedExisting = provider
                                            .categoriesExpense
                                            .map((c) => c.trim().toLowerCase())
                                            .toList();
                                        //this makes all values int the categoryExpese to lowercase
                                        if (_newCatController.text.isNotEmpty &&
                                            newCategory.isNotEmpty)
                                        //isNotEmpty checks and if it is not empty take the action or take else action
                                        {
                                          if (!Provider.of<TransactionProvider>(
                                                      context,
                                                      listen: false)
                                                  .categoriesExpense
                                                  .contains(
                                                      _newCatController.text) &&
                                              !normalizedExisting
                                                  .contains(normalizedNew)) {
                                            final newCategory =
                                                _newCatController.text.trim();
                                            //this adds new category that entered by user into categoriesExpenseAdd and in that void fuction its mentioned to add into categoriesExpense list
                                            Provider.of<TransactionProvider>(
                                                    context,
                                                    listen: false)
                                                .categoriesExpenseAdd(
                                                    newCategory);
                                            _newCatController.clear();
                                            Navigator.of(context).pop();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .tertiary,
                                                    content: Text(
                                                        'Category already exists',
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary))));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            "Category can't be empty",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                          )));
                                        }
                                      },
                                      child: const Text("Add",
                                          style: TextStyle(color: Colors.red))),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ],
                              );
                            });
                      },
                      child: Text(
                        "Add new category",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ))),
              const Text('Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // used flutter_datetime_picker_plus: ^2.2.0 this package to select date and time
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(
                        context,
                        minTime: DateTime(2000, 1, 1),
                        maxTime: DateTime.now(),
                        onConfirm: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: Text(
                      "Select Date & Time",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  Text(
                    selectedDate == null
                        ? "Date not selected"
                        : "${selectedDate!.month} / ${selectedDate!.year}, ${selectedDate!.hour}:${selectedDate!.minute}",
                    style: const TextStyle(
                      fontFamily: 'Antonio',
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_amountController.text.isNotEmpty &&
                          _titleController.text.isNotEmpty &&
                          selectedCategory != null &&
                          selectedDate != null) {
                        final newTransaction = {
                          "amount": double.parse(_amountController.text),
                          "title": _titleController.text,
                          "category": selectedCategory,
                          "type": "expense",
                          "date": selectedDate
                        };
                        Provider.of<TransactionProvider>(context, listen: false)
                            .addTransaction(newTransaction);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            content: Text(
                              "values saved",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter all feilds")));
                      }
                    },
                    child: Text(
                      "Save Expense",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
