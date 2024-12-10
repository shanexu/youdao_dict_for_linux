import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/home_tab.dart';
import 'package:youdao_dict_for_linux/src/rust/api/db.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return Consumer<HistoryTabState>(
      builder: (context, state, child) {
        return Column(children: [
          ToggleButtons(
            onPressed: (idx) {
              state.setSelectedIndex(idx);
            },
            isSelected: state.isSelected,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            // selectedBorderColor: Colors.red[700],
            // selectedColor: Colors.white,
            // fillColor: Colors.red[200],
            // color: Colors.red[400],
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            children: const [Text("detail"), Text("summary")],
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: state.selectedIndex == 0
                      ? FutureBuilder(
                          future: state.itemsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const CircularProgressIndicator();
                            }
                            return DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('ID',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Word',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Time',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Action',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                ],
                                rows: snapshot.data!
                                    .map((r) => DataRow(cells: [
                                          DataCell(Text(r.id.toString())),
                                          DataCell(Text(r.word)),
                                          DataCell(Text(
                                              formatter.format(r.createdAt))),
                                          DataCell(Row(children: [
                                            IconButton(
                                                onPressed: () {
                                                  DefaultTabController.of(
                                                          context)
                                                      .animateTo(0);
                                                  context
                                                      .read<HomeTabState>()
                                                      .setSearchWord(r.word);
                                                },
                                                icon: const Icon(Icons.search)),
                                            IconButton(
                                                onPressed: () async {
                                                  var state = context
                                                      .read<HistoryTabState>();
                                                  var items =
                                                      await state.itemsFuture;
                                                  items.remove(r);
                                                  state.setItems(items);
                                                  await deleteHistory(id: r.id);
                                                  state.refreshSummary();
                                                },
                                                icon: const Icon(Icons.delete))
                                          ]))
                                        ]))
                                    .toList());
                          })
                      : FutureBuilder(
                          future: state.summariesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return const CircularProgressIndicator();
                            }
                            return DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Word',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('count',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Action',
                                              style: TextStyle(
                                                  fontStyle:
                                                      FontStyle.italic))))
                                ],
                                rows: snapshot.data!
                                    .map((r) => DataRow(cells: [
                                          DataCell(Tooltip(
                                              message: r.result?.simpleDict,
                                              waitDuration: const Duration(seconds: 2),
                                              child: Text(r.word))),
                                          DataCell(Text(r.count.toString())),
                                          DataCell(Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    DefaultTabController.of(
                                                            context)
                                                        .animateTo(0);
                                                    context
                                                        .read<HomeTabState>()
                                                        .setSearchWord(r.word);
                                                  },
                                                  icon:
                                                      const Icon(Icons.search)),
                                              IconButton(onPressed: () async {
                                                var state = context.read<HistoryTabState>();
                                                var summaries = await state.summariesFuture;
                                                if (r.count == 1) {
                                                  summaries.remove(r);
                                                } else {
                                                  var nr = HistorySummary(word: r.word, count: r.count -1, result: r.result);
                                                  summaries[summaries.indexOf(r)] = nr;
                                                }
                                                state.setSummaries(summaries);
                                                await deleteOneOldestHistory(word: r.word);
                                                state.refreshHistory();
                                              }, icon: const Icon(Icons.exposure_minus_1))
                                            ],
                                          ))
                                        ]))
                                    .toList());
                          })))
        ]);
      },
    );
  }
}

class HistoryTabState with ChangeNotifier {
  Future<List<History>> itemsFuture = Future.value([]);
  Future<List<HistorySummary>> summariesFuture = Future.value([]);
  int selectedIndex = 0;

  setSelectedIndex(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }

  List<bool> get isSelected => [selectedIndex == 0, selectedIndex == 1];

  refreshAll() {
    itemsFuture = listHistory();
    summariesFuture = historySummaryWithCachedResult();
    notifyListeners();
  }

  refreshHistory() {
    itemsFuture = listHistory();
    notifyListeners();
  }

  refreshSummary() {
    summariesFuture = historySummaryWithCachedResult();
    notifyListeners();
  }

  setItems(List<History> items) {
    itemsFuture = Future.value(items);
    notifyListeners();
  }

  setItemsFuture(Future<List<History>> itemsFuture) {
    this.itemsFuture = itemsFuture;
    notifyListeners();
  }

  setSummaries(List<HistorySummary> summaries) {
    summariesFuture = Future.value(summaries);
    notifyListeners();
  }
}
