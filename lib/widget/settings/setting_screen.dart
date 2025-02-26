import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/workmanager_provider.dart';
import 'package:restaurant_app/service/local_notification_services.dart';
import 'package:restaurant_app/service/workmanager_service.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/widget/settings/theme_toggle_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text("Settings",
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            ThemeToggleWidget(),
            Text(
              "Notification",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Set At 11 Am",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ),
                          ToggleSwitch(
                            minWidth: 50.0,
                            minHeight: 30.0,
                            cornerRadius: 20.0,
                            activeBgColors: [
                              [Colors.cyan],
                              [Colors.redAccent]
                            ],
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 2,
                            initialLabelIndex: context
                                    .watch<LocalNotificationProvider>()
                                    .isNotificationSet
                                ? 0
                                : 1,
                            labels: ['YES', ''],
                            icons: [null, Icons.cancel_presentation_sharp],
                            onToggle: (index) async {
                              if (index == 0) {
                                await _scheduleDailyElevenAMNotification();
                              } else {
                                await _disableNotifications(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Check Pending",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ),
                          FilledButton(
                            onPressed: () async {
                              await _checkPendingNotificationRequests();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors
                                  .blueGrey, // Warna latar belakang tombol
                              foregroundColor:
                                  Colors.white, // Warna teks tombol
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 15.0), // Padding tombol
                            ),
                            child: Icon(Icons.pending),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Set Resto Hits",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ),
                          ToggleSwitch(
                            minWidth: 50.0,
                            minHeight: 30.0,
                            cornerRadius: 20.0,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            totalSwitches: 2,
                            icons: [
                              Icons.check,
                              Icons.cancel_presentation_sharp
                            ],
                            activeBgColors: [
                              [Colors.blue],
                              [Colors.pink]
                            ],
                            initialLabelIndex: context
                                    .watch<WorkmanagerService>()
                                    .isTaskRunning
                                ? 0
                                : 1,
                            onToggle: (index) {
                              if (index == 0) {
                                _runBackgroundPeriodicTask();
                              } else {
                                _cancelAllTaskInBackground();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _scheduleDailyElevenAMNotification() async {
    context
        .read<LocalNotificationProvider>()
        .scheduleDailyElevenAMNotification();
  }

  Future<void> _disableNotifications(BuildContext context) async {
    // Calling checkPendingNotificationRequests from LocalNotificationProvider
    await context
        .read<LocalNotificationProvider>()
        .checkPendingNotificationRequests(context);

    // Get pending notifications from provider
    final pendingNotifications =
        context.read<LocalNotificationProvider>().pendingNotificationRequests;

    // Cancel and delete each pending notification
    for (var request in pendingNotifications) {
      await context
          .read<LocalNotificationProvider>()
          .cancelNotification(request.id);
      await context
          .read<LocalNotificationProvider>()
          .deleteSavedNotification(request.id);
    }
  }

  Future<void> _checkPendingNotificationRequests() async {
    final localNotificationProvider = context.read<LocalNotificationProvider>();

    // Pastikan pending notification requests terbaru didapat
    await localNotificationProvider.checkPendingNotificationRequests(context);

    if (!mounted) {
      return;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Mendapatkan pending notifications
        final pendingData = context.select(
            (LocalNotificationProvider provider) =>
                provider.pendingNotificationRequests);
        return AlertDialog(
          title: Text(
            '${pendingData.length} pending requests',
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: pendingData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = pendingData[index];
                return ListTile(
                    title: Text(
                      item.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.body ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    contentPadding: EdgeInsets.zero,
                    trailing: SizedBox());
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _runBackgroundPeriodicTask() async {
    context.read<WorkmanagerService>().runPeriodicTask();
  }

  void _cancelAllTaskInBackground() async {
    context.read<WorkmanagerService>().cancelAllTask();
  }
}
