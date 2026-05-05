import 'package:flutter/material.dart';

class CustomBookImageLoadingIndicator extends StatefulWidget {
  const CustomBookImageLoadingIndicator({super.key});

  @override
  State<CustomBookImageLoadingIndicator> createState() =>
      _CustomBookImageLoadingIndicatorState();
}

class _CustomBookImageLoadingIndicatorState
    extends State<CustomBookImageLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(color: Colors.grey[50]),
      // Image.asset(image, fit: BoxFit.fill),
    );
  }
}
