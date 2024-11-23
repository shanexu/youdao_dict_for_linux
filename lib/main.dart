import 'package:flutter/material.dart';
import 'package:youdao_dict_for_linux/src/rust/api/simple.dart';
import 'package:youdao_dict_for_linux/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.settings)),
            ],
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text(
                    'Action: Call Rust `greet("Tom")`\nResult: `${greet(name: "Tom")}`'),
              ),
              const Center(
                child: Text("history"),
              ),
              const Center(
                child: Text("settings"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
