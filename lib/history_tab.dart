import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/state.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Consumer<Counter>(
              builder: (context, counter, child) => Text('${counter.value}')),
          TextButton(
              onPressed: () {
                var counter = context.read<Counter>();
                counter.increment();
              },
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}
