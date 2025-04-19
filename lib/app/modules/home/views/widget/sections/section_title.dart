import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatefulWidget {
  const SectionTitle({
    super.key,
    required String title,
  }) : _title = title;
  final String _title;

  @override
  State<SectionTitle> createState() => _SectionTitleState();
}

class _SectionTitleState extends State<SectionTitle> {
  final GlobalKey _textKey = GlobalKey();

   double _textWidth = 0;

   @override
  void initState() {
    super.initState();

     WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextWidth();
    });
    
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget._title,
            style: GoogleFonts.cairo(
              fontSize: 28,
              color: AppColor.lightColor,
            ),
            key: _textKey,
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 4,
            width: _textWidth,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
