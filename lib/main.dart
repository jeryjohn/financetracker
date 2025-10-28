import 'package:finance_tracker/pages/home_page.dart';
import 'package:finance_tracker/theme/theme_provider.dart';
import 'package:finance_tracker/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('transactions');
  await Hive.openBox('themeData');
  await Hive.openBox('categoriesExpense');
  await Hive.openBox("categoriesIncome");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
      ),
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
