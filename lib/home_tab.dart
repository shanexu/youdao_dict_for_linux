import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/src/rust/api/db.dart';
import 'package:youdao_dict_for_linux/src/rust/api/service.dart';

class HomeTab extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();

  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabState>(builder: (context, state, child) {
      var children = <Widget>[
        TextField(
          controller: _inputController,
          onSubmitted: (value) {
            state.setSearchWord(_inputController.text);
          },
          decoration: InputDecoration(
            prefixIcon: IconButton(
                onPressed: () {
                  state.setSearchWord(_inputController.text);
                },
                icon: const Icon(Icons.search)),
            suffixIcon: IconButton(
                onPressed: () {
                  _inputController.clear();
                  state.reset();
                },
                icon: const Icon(Icons.clear)),
            border: const OutlineInputBorder(),
          ),
        )
      ];
      if (state.searchWord != null) {
        children.add(
            Expanded(child: Markdown(selectable: true, data: state.result)));
      }
      return Column(
        mainAxisAlignment: state.searchWord == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: children,
      );
    });
  }
}

class HomeTabState with ChangeNotifier {
  String? searchWord;
  String result = "";

  setSearchWord(String w) async {
    searchWord = w;
    if (w.isEmpty) {
      result = "";
    } else {
      var c = await getWordCache(word: w);
      WordResult r;
      if (c != null) {
        r = c.result;
      } else {
        r = await wordResult(word: w);
        await upsertWordCache(word: w, result: r);
      }
      result = r.notFound
          ? '${r.wordHead}\n\n${r.maybe}\n'
          : '${r.wordHead}:\n\n${r.phoneCon}\n\n${r.simpleDict}\n\n${r.catalogueSentence}\n';
      if (!r.notFound) {
        await createHistory(word: w);
      }
    }
    notifyListeners();
  }

  reset() {
    searchWord = null;
    result = "";
    notifyListeners();
  }
}
