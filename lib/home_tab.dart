import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:youdao_dict_for_linux/src/rust/api/service.dart';

class HomeTab extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController();

  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeTabState>(
        builder: (context, state, child) => Column(
              mainAxisAlignment: state.searchWord == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _inputController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {
                          state.setSearchWord(_inputController.text);
                        },
                        icon: const Icon(Icons.search)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _inputController.clear();
                        },
                        icon: const Icon(Icons.clear)),
                    border: const OutlineInputBorder(),
                  ),
                ),
                Expanded(child: Markdown(selectable: true, data: state.result)),
              ],
            ));
  }
}

class HomeTabState with ChangeNotifier {
  String? searchWord;
  String result = "";

  setSearchWord(String w) async {
    searchWord = w;
    var r = await wordResult(word: w);
    result = '${r.wordHead}:\n\n${r.phoneCon}\n\n${r.simpleDict}\n\n${r.catalogueSentence}\n';
    notifyListeners();
  }
}
