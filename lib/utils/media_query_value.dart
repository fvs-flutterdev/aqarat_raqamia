
import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  // double get toPadding => MediaQuery.sizeOf(this).top;
  // double get bottom => MediaQuery.sizeOf(this).viewInsets.bottom;
}