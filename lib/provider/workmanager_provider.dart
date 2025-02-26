import 'package:flutter/widgets.dart';
import 'package:restaurant_app/service/workmanager_service.dart';

class WorkmanagerProvider extends ChangeNotifier {
  final WorkmanagerService workmanagerService;
  bool _isTaskRunning = false;

  WorkmanagerProvider(this.workmanagerService);

  bool get isTaskRunning => _isTaskRunning;

  // Fungsi untuk menjalankan atau menghentikan tugas sesuai dengan status toggle
  Future<void> toggleHitsNotification(bool isEnabled) async {
    if (isEnabled) {
      await workmanagerService.runPeriodicTask(); // Mulai tugas periodik
      _isTaskRunning = true; // Set status menjadi true
    } else {
      await workmanagerService.cancelAllTask(); // Hentikan semua tugas
      _isTaskRunning = false; // Set status menjadi false
    }
    notifyListeners(); // Memberitahukan listener untuk memperbarui UI
  }
}
