import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme/theme_provider.dart';

class ThemeRobot {
  final WidgetTester tester;

  ThemeRobot(this.tester);

  Future<void> toggleTheme() async {
    final themeProvider = tester
        .element(find.byType(Provider<ThemeProvider>))
        .read<ThemeProvider>();
    themeProvider.toggleTheme();
    await tester.pumpAndSettle();
  }
}
