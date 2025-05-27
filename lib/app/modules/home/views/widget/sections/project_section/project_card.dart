import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    super.key,
    required this.image,
    required this.projectName,
    required this.projectdiscreption,
    required this.tags,
    required this.onHover,
    required this.isHover,
  });

  final String image;
  final String projectName;
  final String projectdiscreption;
  final List<String> tags;
  final void Function(bool)? onHover;
  final bool isHover;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  bool isButtonHover = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant ProjectCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isHover != oldWidget.isHover) {
      widget.isHover ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => widget.onHover?.call(true),
      onExit: (_) => widget.onHover?.call(false),
      // cursor: SystemMouseCursors.click,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: Get.width * 0.30,
              minHeight: 550,
            ),
            child: Card.filled(
              color: AppColor.darkBackgroundColor,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.blue,
                          image: DecorationImage(
                            image: AssetImage(widget.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Text(
                          widget.projectName,
                          style: GoogleFonts.tajawal(
                            color: AppColor.lightColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        subtitle: Text(
                          widget.projectdiscreption,
                          style: GoogleFonts.tajawal(
                            color: AppColor.lightColor,
                            fontSize: 16,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          textDirection: TextDirection.rtl,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.end,
                          children: List.generate(
                            widget.tags.length,
                            (index) => IntrinsicWidth(
                              child: Card.filled(
                                color: AppColor.primaryColor.withAlpha(51),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      widget.tags[index],
                                      style: GoogleFonts.tajawal(
                                        color: AppColor.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 10.0),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 550,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(100),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.white.withAlpha(30),
                            ),
                          ),
                          child: Center(
                            child: IntrinsicHeight(
                              child: IntrinsicWidth(
                                child: InkWell(
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    onEnter: (event) =>
                                        setState(() => isButtonHover = true),
                                    onExit: (event) =>
                                        setState(() => isButtonHover = false),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isButtonHover
                                            ? AppColor.hoverPrimaryColor
                                            : AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black54,
                                            blurRadius: 3,
                                            // spreadRadius: 1,
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Row(
                                          spacing: 5,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Code",
                                              style: GoogleFonts.tajawal(
                                                color: AppColor.lightColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Ionicons.logo_github,
                                              color: AppColor.lightColor,
                                              size: 25,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
