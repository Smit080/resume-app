import 'package:flutter/material.dart';

class ScreenModel {
  final String icon;
  final String title;
  final Widget screen;

  ScreenModel({
    required this.title,
    required this.icon,
    required this.screen,
  });
}
