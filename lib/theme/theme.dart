import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

final theme = ThemeData.light().copyWith(
  
  primaryColor: AppColor.black,
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColor.black,
    secondary: AppColor.black,
  ),
);
