import 'package:flutter/material.dart';

class WebLayout extends StatelessWidget {
  final Widget child;
  const WebLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
}
