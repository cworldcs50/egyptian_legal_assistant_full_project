import 'dart:developer';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'egyptian_legal_assistant.dart';
import 'core/services/service_locator.dart';
import 'core/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'core/shared_preference/shared_preference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.instance.init();
  await serviceLocator();
  await sl.allReady();
  await NotificationService.instance.subscribeToTopic('allUsers');
  String? token = await FirebaseMessaging.instance.getToken();
  log("TOKEN: $token");
  await SharedPreference.init();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const EgyptianLegalAssistant(),
    ),
  );
}
