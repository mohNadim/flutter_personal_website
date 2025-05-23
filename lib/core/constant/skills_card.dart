import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/models/skills_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<SkillsModel> skills = [
  SkillsModel(
    icon: FontAwesomeIcons.flutter,
    skillName: "Flutter",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.dartLang,
    skillName: "Dart",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.android,
    skillName: "Android",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.apple,
    skillName: "Ios",
  ),
  SkillsModel(
    icon: Icons.web,
    skillName: "Web",
  ),
  SkillsModel(icon: FontAwesomeIcons.toolbox, skillName: "State Management"),
  SkillsModel(
    icon: FontAwesomeIcons.fire,
    skillName: "Firebase",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.database,
    skillName: "Hive",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.gitAlt,
    skillName: "Git",
  ),
  SkillsModel(
    icon: FontAwesomeIcons.codeBranch,
    skillName: "State Management",
  ),
];
