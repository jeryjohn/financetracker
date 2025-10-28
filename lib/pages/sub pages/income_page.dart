import 'package:finance_tracker/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _newCatController = TextEditingController();
  // final List<String> categories = [
  //   "Salary",
  //   "Interest",
  //   "Incentives",
  //   "Others"
  // ];
  String? selectedCategory;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final List<String> categories =
        Provider.of<TransactionProvider>(context).categoriesIncome;
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Amount',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Card(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Enter amount",
                    hintStyle: TextStyle(),
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
                    hintStyle: TextStyle(),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                dropdownColor: Theme.of(context).colorScheme.primary,
                hint: const Text(
                  "Select Category",
                  style: TextStyle(),
                ),
                value: selectedCategory,
                isExpanded: true,
                items: categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
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
                                            .categoriesIncome
                                            .map((c) => c.trim().toLowerCase())
                                            .toList();
                                        //this makes all values int the categoryExpese to lowercase
                                        if (_newCatController.text.isNotEmpty &&
                                            newCategory.trim().isNotEmpty) {
                                          //isNotEmpty checks and if it is not empty take the action or take else action && if there is empty space ater value
                                          if (!provider.categoriesIncome
                                                  .contains(
                                                      _newCatController.text) &&
                                              !normalizedExisting
                                                  .contains(normalizedNew)) {
                                            //this adds new category that entered by user into categoriesIncomeAdd and in that void fuction its mentioned to add into categoriesIncome list
                                            final newCategory =
                                                _newCatController.text.trim();
                                            Provider.of<TransactionProvider>(
                                                    context,
                                                    listen: false)
                                                .categoriesIncomeAdd(
                                                    newCategory);
                                            _newCatController.clear();
                                            Navigator.of(context).pop();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              'Category already exists',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                            )));
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .tertiary,
                                                  content: Text(
                                                    "Categoty cant be empty",
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
              const SizedBox(height: 20),
              const Text('Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // used flutter_datetime_picker_plus: ^2.2.0 this package to select date and time
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      picker.DatePicker.showDateTimePicker(
                        context,
                        minTime: DateTime(2023, 1, 1),
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
                          fontFamily: 'Antonio',
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
                          "date": selectedDate,
                          "type": "income"
                        };
                        provider.addTransaction(newTransaction);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
                              content: Text("values saved",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Save Income",
                      style: TextStyle(
                          fontFamily: 'Antonio',
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
                      style:
                          TextStyle(fontFamily: 'Antonio', color: Colors.red),
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
