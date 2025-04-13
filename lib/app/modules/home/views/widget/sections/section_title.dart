import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required GlobalKey<State<StatefulWidget>> textKey,
    required double textWidth,
    required String title,
  })  : _textKey = textKey,
        _textWidth = textWidth,
        _title = title;

  final GlobalKey<State<StatefulWidget>> _textKey;
  final double _textWidth;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _title,
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
