import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutItem extends StatefulWidget {
  const AboutItem({
    super.key,
    required this.isLeft,
    required this.icon,
    required this.title,
    required this.content,
    required this.isAnimate,
  });

  final bool isLeft;
  final Icon icon;
  final String title;
  final String content;
  final bool isAnimate;

  @override
  State<AboutItem> createState() => _AboutItemState();
}

class _AboutItemState extends State<AboutItem>
    with SingleTickerProviderStateMixin {
  final GlobalKey _containerSize = GlobalKey();

  double _containerWidth = 0;
  double _containerHeight = 0;

  late AnimationController _controller;

  late Animation<Offset> moveDownToUpAnimation;
  late Animation<Offset> moveLeft;
  late Animation<Offset> moveRight;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextWidth();
    });

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
    moveLeft = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    moveRight = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AboutItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned(
                top: _containerHeight / 2 - 9,
                right: _containerWidth / 2 - 9,
                child: SlideTransition(
                  position: moveDownToUpAnimation,
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: widget.isLeft
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: SlideTransition(
                  position: widget.isLeft ? moveLeft : moveRight,
                  child: FadeTransition(
                    opacity: fadeAnimation,
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
                            spacing: 8,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
