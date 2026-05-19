import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DrawerItemModel extends Equatable {
  final IconData icon;
  final String title, route;

  const DrawerItemModel({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  List<Object?> get props => [title, icon, route];
}
