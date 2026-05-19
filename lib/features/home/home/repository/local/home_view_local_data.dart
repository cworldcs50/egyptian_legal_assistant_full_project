import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../models/drawer_item_model.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomeViewLocalData {
  static const String sources = 'المصادر';
  static const String logout = 'تسجيل الخروج';
  static const String settings = 'الإعدادات';
  static const String about = 'حول التطبيق';
  static const String newChat = 'محادثة جديدة';
  static const String laws = 'القوانين المستخدمة';
  static const String userEmail = 'mohamed@example.com';
  static const String userName = 'محمد أحمد';
  static const String appTitle = 'المساعد القانوني المصري';
  static const IconData aboutIcon = LucideIcons.info;
  static const IconData person = Icons.person;
  static const IconData x = LucideIcons.x;
  static const IconData user = LucideIcons.user;
  static const IconData menu = LucideIcons.menu;
  static const IconData logOutIcon = LucideIcons.logOut;
  static const IconData newChatIcon = LucideIcons.plus;
  static const IconData lawsIcon = LucideIcons.bookOpen;
  static const String previousChats = 'المحادثات السابقة';
  static const IconData sourcesIcon = LucideIcons.bookOpen;
  static const IconData settingsIcon = LucideIcons.settings;
  static const IconData previousChatsIcon = LucideIcons.messageSquare;
  static const String welcomeMessage =
      'مرحباً بك في المساعد القانوني المصري. أنا هنا لمساعدتك في الإجابة على أسئلتك القانونية بناءً على القوانين المصرية الرسمية. كيف يمكنني مساعدتك اليوم؟';

  static List<DrawerItemModel> drawerItems = const [
    DrawerItemModel(
      route: AppConstants.homeRoute,
      title: HomeViewLocalData.newChat,
      icon: HomeViewLocalData.newChatIcon,
    ),
    DrawerItemModel(
      title: HomeViewLocalData.previousChats,
      route: AppConstants.previousChatsRoute,
      icon: HomeViewLocalData.previousChatsIcon,
    ),
    DrawerItemModel(
      title: HomeViewLocalData.sources,
      route: AppConstants.sourcesRoute,
      icon: HomeViewLocalData.sourcesIcon,
    ),
    DrawerItemModel(
      title: HomeViewLocalData.settings,
      route: AppConstants.settingsRoute,
      icon: HomeViewLocalData.settingsIcon,
    ),
    // DrawerItemModel(
    //   title: HomeViewLocalData.laws,
    //   route: AppConstants.lawsRoute,
    //   icon: HomeViewLocalData.lawsIcon,
    // ),
    DrawerItemModel(
      title: HomeViewLocalData.about,
      route: AppConstants.aboutRoute,
      icon: HomeViewLocalData.aboutIcon,
    ),
  ];
}
