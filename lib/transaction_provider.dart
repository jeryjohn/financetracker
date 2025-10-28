import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionProvider extends ChangeNotifier {
  // double food = 0;
  // double travel = 0;
  // double shopping = 0;
  // double health = 0;
  // double salary = 0;
  // double interest = 0;
  // double incentives = 0;
  // double othersIncome = 0;
  // double othersExpense = 0;
  double itemValue = 0;

  final Box _box = Hive.box('transactions');
  final Box _boxCategory = Hive.box("categoriesExpense");
  final Box _boxCategoryI = Hive.box("categoriesIncome");

  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  List<Map<String, dynamic>> _categoryAmountExpense = [];
  List<Map<String, dynamic>> get categoryAmountExpense =>
      _categoryAmountExpense;
  List<Map<String, dynamic>> _categoryAmountIncome = [];
  List<Map<String, dynamic>> get categoryAmountIncome => _categoryAmountIncome;

  List<String> _categoriesExpense = [
    "Food",
    "Travel",
    "Shopping",
  ];
  List<String> get categoriesExpense => _categoriesExpense;

  List<String> _categoriesIncome = [
    "Salary",
    "Interest",
  ];
  List<String> get categoriesIncome => _categoriesIncome;

  TransactionProvider() {
    loadTransactions();
  }

  void categoriesIncomeAdd(String ci) {
    if (ci.isNotEmpty && !categoriesIncome.contains(ci)) {
      categoriesIncome.add(ci);
      notifyListeners();
    }
    _boxCategoryI.add(ci);
    loadTransactions();

    notifyListeners();
  }

  void removeIncCat(int index) {
    if (index >= 2) {
      final key = _boxCategoryI.keyAt(index - 2);
      _boxCategoryI.delete(key);
      loadTransactions();
    }
  }

  void categoriesExpenseAdd(String ce) {
    if (ce.isNotEmpty && !categoriesExpense.contains(ce)) {
      categoriesExpense.add(ce);
    }

    _boxCategory.add(ce);
    loadTransactions();

    notifyListeners();
  }

  void removeExpCat(int index) {
    if (index >= 3) {
      final key = _boxCategory.keyAt(index - 3);
      _boxCategory.delete(key);
      loadTransactions();
    }
  }

  // to Load  transactions to the list from hive also category
  void loadTransactions() {
    try {
      _transactions = _box.values
          .cast<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      _categoriesExpense = ["Food", "Travel", "Shopping"];
      _categoriesIncome = ["Salary", "Interest"];

      List<String> _hiveExpence = _boxCategory.values.cast<String>().toList();
      List<String> _hiveIncome = _boxCategoryI.values.cast<String>().toList();

      _categoriesExpense = [..._categoriesExpense, ..._hiveExpence];
      _categoriesIncome = [..._categoriesIncome, ..._hiveIncome];

      _categoryAmountExpense;
      _categoryAmountIncome;

      categories();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void addTransaction(Map<String, dynamic> tx) {
    // transactions.add(tx);
    _box.add(tx);
    loadTransactions();
    categories();
    notifyListeners();
  }
  //to add entered value to transaction list

  void removeTransaction(int index) {
    _box.deleteAt(index);
    categories();
    loadTransactions();
    notifyListeners();
  }

  void resetApp() {
    _box.clear();
    _transactions.clear();
    _categoryAmountExpense.clear();
    _categoryAmountIncome.clear();
    categories();
    itemValue = 0;
    // food = travel = shopping = health =
    //     salary = interest = incentives = othersIncome = othersExpense = 0;
    notifyListeners();
  }

  double get totalExpense {
    double totalBalance = 0;
    for (var tx in transactions) {
      if (tx["type"] == "expense") {
        totalBalance += (tx["amount"] as num).toDouble();
      }
    }

    return totalBalance;
  }
  //to find total total expense

  double get totalIncome {
    double totalBalance = 0;
    for (var tx in transactions) {
      if (tx["type"] == "income") {
        totalBalance += (tx["amount"] as num).toDouble();
      }
    }

    return totalBalance;
  }
  //to find total icnome

  double get totalBalance {
    return totalIncome - totalExpense;
  }
  //to find the total balance

  void categories() {
    _categoryAmountExpense.clear();
    _categoryAmountIncome.clear();
    // food = travel = shopping = health =
    //     salary = interest = incentives = othersIncome = othersExpense = 0;
    for (var ci in categoriesIncome) {
      String item = ci;
      double itemValue = 0;
      for (var tx in transactions) {
        String category = tx["category"];
        double amount = (tx["amount"] as num).toDouble();
        if (category == item) {
          itemValue += amount;
        }
      }
      _categoryAmountIncome.add({"category": item, "amount": itemValue});
    }

    for (var ce in categoriesExpense) {
      String item = ce;
      double itemValue = 0;
      for (var tx in transactions) {
        String category = tx["category"];
        double amount = (tx["amount"] as num).toDouble();
        if (category == item) {
          itemValue += amount;
        }
      }
      _categoryAmountExpense.add({"category": item, "amount": itemValue});
    }

    // if (category == "Food") {
    //   food += amount;
    // } else if (category == "Travel") {
    //   travel += amount;
    // } else if (category == "Shopping") {
    //   shopping += amount;
    // } else if (category == "Health") {
    //   health += amount;
    // } else if (category == "Salary") {
    //   salary += amount;
    // } else if (category == "Interest") {
    //   interest += amount;
    // } else if (category == "Incentives") {
    //   incentives += amount;
    // } else if (tx["type"] == "expense") {
    //   if (category == "Others") {
    //     othersExpense += amount;
    //   }
    // } else if (tx["type"] == "income") {
    //   if (category == "Others") {
    //     othersIncome += amount;
    //   }
    // }

    notifyListeners();
  }
  //used to find each category total values
}
