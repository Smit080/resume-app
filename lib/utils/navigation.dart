import 'package:flutter/material.dart';

pushPage(BuildContext context, Widget screen) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ));

popPage(BuildContext context) => Navigator.pop(context);

EdgeInsets commonPad() => const EdgeInsets.symmetric(horizontal: 20, vertical: 15);

snack(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
