import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';

class ContactIcon extends StatefulWidget {
  const ContactIcon({
    super.key,
    required this.isHover,
    required this.icon,
  });

  final bool isHover;
  final IconData icon;

  @override
  State<ContactIcon> createState() => _ContactIconState();
}

class _ContactIconState extends State<ContactIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ContactIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isHover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: AppColor.lightColor,
        end: widget.isHover ? AppColor.lightColor : AppColor.primaryColor,
      ),
      duration: const Duration(milliseconds: 300),
      builder: (context, color, _) => IconButton(
        onPressed: () {},
        icon: AnimatedBuilder(
          builder: (context, _) {
            return ScaleTransition(
              scale: scaleAnimation,
              child: Icon(
                widget.icon,
                color: color,
                size: 30,
              ),
            );
          },
          animation: scaleAnimation,
        ),
      ),
    );
  }
}
