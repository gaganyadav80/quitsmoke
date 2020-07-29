import 'package:flutter/material.dart';

class PageViewModel {
  /// Title of page
  final String title;

  /// Title of page
  final Widget titleWidget;

  /// Text of page (description)
  final String body;

  /// Widget content of page (description)
  final Widget bodyWidget;

  final Color bodyColor;

  /// Image of page
  /// Tips: Wrap your image with an alignment widget like Align or Center
  // final Widget image;

  /// Footer widget, you can add a button for example
  // final Widget footer;

  /// Page decoration
  /// Contain all page customizations, like page color, text styles
  // final PageDecoration decoration;

  PageViewModel({
    this.title,
    this.titleWidget,
    this.body,
    this.bodyWidget,
    // this.image,
    // this.footer,
    this.bodyColor,
    // this.decoration,
  });
}
