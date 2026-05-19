import 'dart:developer';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  factory NotificationService() => instance;
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  bool _isRequestingPermission = false;

  Future<void> subscribeToTopic(String topicName) async =>
      await FirebaseMessaging.instance.subscribeToTopic(topicName);

  Future<void> unsubscribeFromTopic(String topicName) async =>
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicName);

  Future<void> init() async {
    if (_isInitialized) return;

    tzdata.initializeTimeZones();
    final TimezoneInfo timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName.identifier));

    // Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization
    final DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _isInitialized = true;
  }

  Future<void> getNotificationPermission() async {
    if (_isRequestingPermission) return;

    try {
      _isRequestingPermission = true;

      await FirebaseMessaging.instance.requestPermission();
    } finally {
      _isRequestingPermission = false;
    }
  }

  NotificationDetails notificationDetails({
    required int id,
    required String body,
    required String title,
  }) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          priority: Priority.high,
          importance: Importance.max,
          channelDescription: 'Daily Notification Channel',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    return platformChannelSpecifics;
  }

  Future<void> showNotification({
    int id = 0,
    required String title,
    required String body,
    String? payload,
  }) async => await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    notificationDetails(id: id, title: title, body: body),
  );

  Future<void> scheduleDailyNotification({
    int id = 1,
    required int hour,
    required int minute,
    required String body,
    required String title,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(id: id, title: title, body: body),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );

    log('Notification scheduled at $scheduledDate');
  }

  Future<void> cancelAllNotifications() async =>
      await flutterLocalNotificationsPlugin.cancelAll();

  Future<void> cancelNotification(int id) async =>
      await flutterLocalNotificationsPlugin.cancel(id);
}
