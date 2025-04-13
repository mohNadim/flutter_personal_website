import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/app_bar/nav_link.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarChild extends StatelessWidget {
  const AppBarChild({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: AppColor.darkColor,
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textDirection: TextDirection.rtl,
          children: [
            //* Gradient Portfolio *//
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColor.primaryColor,
                  AppColor.secondaryColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                "Portfolio",
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            //* App Bar Links *//
            Row(
              children: [
                Obx(
                  () => NavLink(
                    title: 'الرئيسية',
                    href: '#home',
                    isHover: controller.hoverStates[0].value,
                    onHover: (value) => controller.onHover(0, value),
                    // onTap: ,
                  ),
                ),
                Obx(
                  () => NavLink(
                    title: 'عني',
                    href: '#about',
                    isHover: controller.hoverStates[1].value,
                    onHover: (value) => controller.onHover(1, value),
                  ),
                ),
                Obx(
                  () => NavLink(
                    title: 'مشاريعي',
                    href: '#projects',
                    isHover: controller.hoverStates[2].value,
                    onHover: (value) => controller.onHover(2, value),
                  ),
                ),
                Obx(
                  () => NavLink(
                    title: 'تواصل معي',
                    href: '#contact',
                    isHover: controller.hoverStates[3].value,
                    onHover: (value) => controller.onHover(3, value),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
