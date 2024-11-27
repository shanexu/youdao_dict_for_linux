import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/src/rust/api/db.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryTabState>(
        builder: (context, state, child) => SingleChildScrollView(
                child: DataTable(
                    columns: const <DataColumn>[
                  DataColumn(
                      label: Expanded(
                          child: Text('ID',
                              style: TextStyle(fontStyle: FontStyle.italic)))),
                  DataColumn(
                      label: Expanded(
                          child: Text('Word',
                              style: TextStyle(fontStyle: FontStyle.italic)))),
                  DataColumn(
                      label: Expanded(
                          child: Text('Time',
                              style: TextStyle(fontStyle: FontStyle.italic))))
                ],
                    rows: state.items
                        .map((r) => DataRow(cells: [
                              DataCell(Text(r.id.toString())),
                              DataCell(Text(r.word)),
                              DataCell(Text(r.createdAt.toString()))
                            ]))
                        .toList())));
  }
}

class HistoryTabState with ChangeNotifier {
  List<History> items = [];

  refresh() async {
    items = await listHistory();
    notifyListeners();
  }
}
