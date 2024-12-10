import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsTabState>(builder: (context, state, child) {
      return Column(children: [
        ToggleButtons(
          onPressed: (idx) {
            state.setThemeMode(idx == 0 ? ThemeMode.light : ThemeMode.dark);
          },
          isSelected: [state.themeMode == ThemeMode.light, state.themeMode == ThemeMode.dark],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          // selectedBorderColor: Colors.red[700],
          // selectedColor: Colors.white,
          // fillColor: Colors.red[200],
          // color: Colors.red[400],
          constraints: const BoxConstraints(
            minHeight: 32.0,
            minWidth: 32.0,
          ),
          children: const [Icon(Icons.light_mode), Icon(Icons.dark_mode)],
        ),
      ],);
      return const Center(child: Text("settings"));
    });
  }
}

class SettingsTabState with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }
}