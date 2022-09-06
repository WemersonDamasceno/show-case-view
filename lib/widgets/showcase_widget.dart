import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcase extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey keyGlobal;
  final bool showCase;
  final String? title;
  const CustomShowcase({
    Key? key,
    required this.child,
    required this.description,
    this.title,
    required this.keyGlobal,
    required this.showCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showCase
        ? Showcase(
            key: keyGlobal,
            description: description,
            child: child,
          )
        : child;
  }
}
