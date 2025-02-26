import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggleWidget extends StatelessWidget {
  const ThemeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Theme", style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
          ToggleSwitch(
            minWidth: 50.0,
            minHeight: 30.0,
            initialLabelIndex:
                context.watch<ThemeProvider>().themeMode == ThemeMode.dark
                    ? 1
                    : 0,
            cornerRadius: 20.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            icons: [
              Icons.light_mode_outlined,
              Icons.light_mode,
            ],
            iconSize: 30.0,
            activeBgColors: [
              [Colors.yellow, Colors.orange],
              [Colors.black45, Colors.black26],
            ],
            animate:
                true, // with just animate set to true, default curve = Curves.easeIn
            curve: Curves
                .bounceInOut, // animate must be set to true when using custom curve
            onToggle: (index) {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
