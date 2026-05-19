import 'dart:developer';
import '../theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import '../widgets/adaptive_layout.dart';

void showTopSnackBar(BuildContext context, String title, String body) {
  final overlay = Overlay.of(context);

  final overlayEntry = OverlayEntry(
    builder:
        (context) => TweenAnimationBuilder(
          tween: Tween(
            begin: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: -100.0,
            ),
            end: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 50.0),
          ),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return Positioned(
              top: value,
              left: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16.0,
              ),
              right: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16.0,
              ),
              child: child!,
            );
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16.0),
              ),
              decoration: BoxDecoration(
                color: AppColors.primary(context),
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(body, style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void listenToNotification(BuildContext context) {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    log('Notification received: ${message.notification?.title}');

    await FlutterRingtonePlayer().playNotification();

    showTopSnackBar(
      // ignore: use_build_context_synchronously
      context,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
    );
  });
}
