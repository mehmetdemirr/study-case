import 'package:flutter/material.dart';

enum ColorItem {
  white,
  black,
}

extension ColorItems on ColorItem {
  Color str() {
    return switch (this) {
      ColorItem.white => Colors.white,
      ColorItem.black => Colors.black,
    };
  }
}
