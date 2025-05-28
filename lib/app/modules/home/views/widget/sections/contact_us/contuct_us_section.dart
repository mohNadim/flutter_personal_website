import 'package:flutter/material.dart';
import 'package:flutter_personal_website/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/contact_us/contact_icon.dart';
import 'package:flutter_personal_website/app/modules/home/views/widget/sections/section_title.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({
    super.key,
    required this.isAnimate,
    required this.homeController,
  });

  final bool isAnimate;
  final HomeController homeController;

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> slideToUpAnimation;
  late Animation<Offset> slideToRightAnimation;
  late Animation<Offset> slideToLeftAnimation;
  late Animation<double> fadeAnimation;

  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  bool isInstgrameIconHover = false;
  bool isFacebookIconHover = false;
  bool isLinkedinIconHover = false;
  bool isTiktokIconHover = false;
  bool isWhatsappIconHover = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    slideToUpAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(_controller);

    slideToLeftAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(_controller);

    slideToRightAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(_controller);

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);

    _fadeAnimations = List.generate(
      4,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        );
      },
    );

    _slideAnimations = List.generate(
      4,
      (index) {
        double start = index * 0.25;
        double end = start + 0.25;

        return Tween<Offset>(begin: Offset(-0.2, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(start, end, curve: Curves.linear),
          ),
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant ContactUs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimate) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideToUpAnimation,
                    child: const SectionTitle(
                      title: "تواصل معي",
                      bottomPadding: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * 0.7,
                    minHeight: Get.height * 0.5,
                  ),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColor.darkBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SlideTransition(
                            position: slideToRightAnimation,
                            child: FadeTransition(
                              opacity: fadeAnimation,
                              child: Lottie.asset(
                                "assets/plant.json",
                                width: 400,
                              ),
                            ),
                          ),
                          Column(
                            spacing: 20,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: [
                              //* Title
                              SlideTransition(
                                position: _slideAnimations[0],
                                child: FadeTransition(
                                  opacity: _fadeAnimations[0],
                                  child: Text(
                                    "شكراً لكم لزيارة موقعي",
                                    style: GoogleFonts.tajawal(
                                      color: AppColor.primaryColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              //* Paragraph
                              SlideTransition(
                                position: _slideAnimations[1],
                                child: FadeTransition(
                                  opacity: _fadeAnimations[1],
                                  child: Text(
                                    "في هذا الركن الهادئ من الفضاء، حيث تتناثر الأفكار كنجوم تضيء العتمة...\nيسعدني أن تشاركوني رحلتي بين عوالم أصنعها بشغف...\nهنا، لا جاذبية تُقيد الخيال، ولا حدود توقف الإبداع...\nلعلّكم تجدون هنا ما يحرّك في داخلكم فكرة... أو يشعل شرارة حلمٍ نائم.",
                                    style: GoogleFonts.tajawal(
                                      color: AppColor.lightColor,
                                      fontSize: 20,
                                      height: 1.5,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: _slideAnimations[2],
                                child: FadeTransition(
                                  opacity: _fadeAnimations[2],
                                  child: RichText(
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(
                                      text: "يمكنكم",
                                      style: GoogleFonts.tajawal(
                                        color: AppColor.lightColor,
                                        fontSize: 20,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " التواصل ",
                                          style: GoogleFonts.tajawal(
                                            color: AppColor.primaryColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(text: "معي عبر :")
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //* Icons
                              SlideTransition(
                                position: _slideAnimations[3],
                                child: FadeTransition(
                                  opacity: _fadeAnimations[3],
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    spacing: 5,
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      MouseRegion(
                                        onEnter: (event) => setState(
                                            () => isFacebookIconHover = true),
                                        onExit: (event) => setState(
                                            () => isFacebookIconHover = false),
                                        child: ContactIcon(
                                          isHover: isFacebookIconHover,
                                          icon: Ionicons.logo_facebook,
                                        ),
                                      ),
                                      MouseRegion(
                                        onEnter: (event) => setState(
                                            () => isLinkedinIconHover = true),
                                        onExit: (event) => setState(
                                            () => isLinkedinIconHover = false),
                                        child: ContactIcon(
                                          isHover: isLinkedinIconHover,
                                          icon: Ionicons.logo_linkedin,
                                        ),
                                      ),
                                      MouseRegion(
                                        onEnter: (event) => setState(
                                            () => isTiktokIconHover = true),
                                        onExit: (event) => setState(
                                            () => isTiktokIconHover = false),
                                        child: ContactIcon(
                                          isHover: isTiktokIconHover,
                                          icon: Ionicons.logo_tiktok,
                                        ),
                                      ),
                                      MouseRegion(
                                        onEnter: (event) => setState(
                                            () => isWhatsappIconHover = true),
                                        onExit: (event) => setState(
                                            () => isWhatsappIconHover = false),
                                        child: ContactIcon(
                                          isHover: isWhatsappIconHover,
                                          icon: Ionicons.logo_whatsapp,
                                        ),
                                      ),
                                      MouseRegion(
                                        onEnter: (event) => setState(
                                            () => isInstgrameIconHover = true),
                                        onExit: (event) => setState(
                                            () => isInstgrameIconHover = false),
                                        child: ContactIcon(
                                          isHover: isInstgrameIconHover,
                                          icon: Ionicons.logo_instagram,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
