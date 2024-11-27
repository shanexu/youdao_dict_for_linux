import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/history_tab.dart';
import 'package:youdao_dict_for_linux/home_tab.dart';
import 'package:youdao_dict_for_linux/src/rust/api/db.dart';
import 'package:youdao_dict_for_linux/src/rust/frb_generated.dart';

const paddingEdge = 16.0;

Future<void> main() async {
  await RustLib.init();
  await initDb();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => HistoryTabState()),
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
          appBar: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.history)),
              Tab(icon: Icon(Icons.settings)),
            ],
            onTap: (idx) async {
              if (idx == 1) {
                await context.read<HistoryTabState>().refresh();
              }
            },
          ),
          body: TabBarView(
            children: [
              Padding(
                  padding: const EdgeInsets.all(paddingEdge), child: HomeTab()),
              const Padding(
                  padding: EdgeInsets.all(paddingEdge), child: HistoryTab()),
              const Padding(
                  padding: EdgeInsets.all(paddingEdge),
                  child: Center(child: Text("settings"))),
            ],
          ),
        ),
      ),
    );
  }
}
