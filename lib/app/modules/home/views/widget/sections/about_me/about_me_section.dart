import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/about_me/about_item.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/section_title.dart';
import 'package:flutter_personal_website/core/constant/about_me_card.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key, required this.isAnimate});
  final bool isAnimate;

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> moveDownToUpAnimation;
  late Animation<double> fadeAnimation;
  final GlobalKey _textKey = GlobalKey();
  double _textWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    moveDownToUpAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextWidth();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant AboutMeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _getTextWidth() {
    final RenderBox? renderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && mounted) {
      setState(() {
        _textWidth = renderBox.size.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber, //Todo : remove after use.
      width: Get.width,
      height: Get.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: moveDownToUpAnimation,
              child: SectionTitle(textKey: _textKey, textWidth: _textWidth, title: 'من أنا ؟',),
            ),
          ),
          Stack(
            children: [
              //* Main line in center (main Axis)
              AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return SlideTransition(
                      position: moveDownToUpAnimation,
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: Align(
                          child: Container(
                            width: 5,
                            height: Get.height * .6,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              //Todo : Point and Text Box (Center in main axis and spacebetween on cross axis)
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: Get.width * .5,
                  height: Get.height * .6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      aboutCards.length,
                      (index) => AboutItem(
                        isLeft: index % 2 == 0,
                        icon: aboutCards[index].icon,
                        title: aboutCards[index].title,
                        content: aboutCards[index].content,
                        isAnimate: widget.isAnimate,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
