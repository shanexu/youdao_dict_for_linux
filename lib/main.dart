import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/history_tab.dart';
import 'package:youdao_dict_for_linux/home_tab.dart';
import 'package:youdao_dict_for_linux/src/rust/frb_generated.dart';
import 'package:youdao_dict_for_linux/state.dart';

const padding_edge = 16.0;

Future<void> main() async {
  await RustLib.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Counter()),
    ChangeNotifierProvider(create: (context) => HomeTabState()),
  ], child: const MyApp()));
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
              Padding(padding: const EdgeInsets.all(padding_edge), child: HomeTab()),
              const Padding(
                  padding: EdgeInsets.all(padding_edge), child: HistoryTab()),
              const Padding(
                  padding: EdgeInsets.all(padding_edge),
                  child: Center(child: Text("settings"))),
            ],
          ),
        ),
      ),
    );
  }
}
