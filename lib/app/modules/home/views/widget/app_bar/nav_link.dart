import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NavLink extends StatefulWidget {
  const NavLink({
    super.key,
    required this.title,
    required this.href,
    required this.isHover,
    this.onHover,
    this.onTap,
  });

  final String title;
  final String href;
  final bool isHover;
  final void Function(bool)? onHover;
  final void Function()? onTap;

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderAnimation;
  final GlobalKey _textKey = GlobalKey();
  double _textWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.ease),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextWidth();
    });
  }

  @override
  void didUpdateWidget(covariant NavLink oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHover != oldWidget.isHover) {
      widget.isHover ? _controller.forward() : _controller.reverse();
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        onEnter: (_) => widget.onHover?.call(true),
        onExit: (_) => widget.onHover?.call(false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: AppColor.lightColor,
                  end: widget.isHover
                      ? AppColor.primaryColor
                      : AppColor.lightColor,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, color, child) {
                  return Text(
                    widget.title,
                    key: _textKey,
                    style: GoogleFonts.cairo(
                      color: color,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              AnimatedBuilder(
                animation: _borderAnimation,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 2,
                      width: _textWidth * _borderAnimation.value,
                      color: AppColor.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
