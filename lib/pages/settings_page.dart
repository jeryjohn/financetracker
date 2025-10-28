import 'package:finance_tracker/theme/theme_provider.dart';
import 'package:finance_tracker/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Settings",
        style: TextStyle(
          fontFamily: 'Antonio',
        ),
      )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Provider.of<TransactionProvider>(context, listen: false)
                      .resetApp();
                },
                child: const Text(
                  'reset app',
                  style: TextStyle(
                    fontFamily: 'Antonio',
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text(
                    "Swtich theme",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Antonio',
                    ),
                  ),
                  trailing: ToggleSwitch(
                    minWidth: 60.0,
                    minHeight: 70.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    totalSwitches: 2,
                    icons: const [Icons.light_mode, Icons.dark_mode],
                    iconSize: 30.0,
                    animate: true,
                    curve: Curves.bounceInOut,
                    onToggle: (index) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: Theme.of(context).colorScheme.tertiary,
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.android),
                      title: Text(
                        "App Name",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                      subtitle: Text(
                        "Finance Tracker",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text(
                        "App Version",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                      subtitle: Text(
                        "1.1.1",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.email_outlined),
                      title: Text(
                        "Contact",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                      subtitle: Text(
                        "ftsupport@gmail.com",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        "About",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                      subtitle: Text(
                        "This is a simple personal finance tracker app",
                        style: TextStyle(
                          fontFamily: 'Antonio',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
