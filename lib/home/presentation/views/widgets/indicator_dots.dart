import 'package:code_books/contants.dart';
import 'package:flutter/material.dart';

Widget indicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    height: 8.0,
    width: isActive ? 28 : 8,
    decoration: BoxDecoration(
      color: isActive ? kPrimaryColor : kSliverColor,
      borderRadius: BorderRadius.circular(20),
    ),
  );
}
