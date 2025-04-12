import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/about_me_card.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber, //Todo : remove after use.
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Stack(
        children: [
          //* Main line in center (main Axis)
          Align(
            child: Container(
              width: 5,
              height: Get.height * .8,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          //Todo : Point and Text Box (Center in main axis and spacebetween on cross axis)
          Align(
            child: SizedBox(
              width: Get.width * .5,
              height: Get.height * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  aboutCards.length,
                  (index) => AboutItem(
                      isLeft: index % 2 == 0,
                      icon: aboutCards[index].icon,
                      title: aboutCards[index].title,
                      content: aboutCards[index].content),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AboutItem extends StatefulWidget {
  const AboutItem({
    super.key,
    required this.isLeft,
    required this.icon,
    required this.title,
    required this.content,
  });

  final bool isLeft;
  final Icon icon;
  final String title;
  final String content;

  @override
  State<AboutItem> createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem> {
  final GlobalKey _containerSize = GlobalKey();

  double _containerWidth = 0;
  double _containerHeight = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextWidth();
    });
  }

  void _getTextWidth() {
    final RenderBox? renderBox =
        _containerSize.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _containerWidth = renderBox.size.width;
        _containerHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerSize,
      // color: Colors.amber,
      child: Stack(
        children: [
          Positioned(
            // alignment: Alignment.center,
            top: _containerHeight / 2 - 9,
            right: _containerWidth / 2 - 9,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment:
                widget.isLeft ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.all(10),
              width: 350,
                decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Row(
                    spacing: 5,
                    textDirection: TextDirection.rtl,
                    children: [
                      widget.icon,
                      Text(
                        widget.title,
                        style: GoogleFonts.cairo(
                          color: AppColor.darkColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.content,
                    textDirection: TextDirection.rtl,
                    // overflow: TextOverflow.fade,
                    style: GoogleFonts.cairo(
                      color: AppColor.darkColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Todo : remove after use
