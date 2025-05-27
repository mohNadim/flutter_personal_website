import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
        theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(AppColor.primaryColor),
          trackColor: WidgetStateProperty.all(Colors.grey.shade300),
          radius: Radius.circular(10),
          thickness: WidgetStateProperty.all(8),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
