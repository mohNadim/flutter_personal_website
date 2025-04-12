import 'package:flutter/material.dart';
import 'package:flutter_personal_website/core/constant/colors.dart';
import 'package:flutter_personal_website/core/static_models/about_me_model.dart';
import 'package:ionicons/ionicons.dart';

List<AboutMeModel> aboutCards = [
  AboutMeModel(
    icon: Icon(
      Ionicons.school,
      color: AppColor.darkColor,
    ),
    title: "التعليم",
    content:
        "أنا طالب في السنة الرابعة بكلية تكنولوجيا المعلومات (ITE)، أتابع دراستي لنيل درجة البكالوريوس في تكنولوجيا المعلومات منذ عام 2021، مع تركيز على تنمية المهارات التقنية والعملية في مجالات الحوسبة الحديثة.",
  ),
  AboutMeModel(
    icon: Icon(
      Ionicons.person_add,
      color: AppColor.darkColor,
    ),
    title: "الخبرة",
    content:
        "Flutter Developer بخبرة سنتين في تطوير تطبيقات الهواتف، عملت على عدة مشاريع عملية، بالإضافة إلى تدريب لمدة 5 أشهر ساهمت خلاله في تطوير تطبيقات باستخدام Flutter ضمن بيئة عمل فريقية.",
  ),
  AboutMeModel(
    icon: Icon(
      Ionicons.construct,
      color: AppColor.darkColor,
    ),
    title: "المهارات التقنية",
    content:
        "أمتلك مهارات تقنية قوية في تطوير تطبيقات الهواتف باستخدام Flutter وDart، مع خبرة في التعامل مع REST APIs. لدي معرفة جيدة في إدارة الحالة باستخدام مكتبات مثل Provider وGetX وBLoC. كما أتمتع بمهارات في العمل مع قواعد البيانات مثل Firebase وSupabase وHive. بالإضافة إلى ذلك، لدي أساس قوي في تصميم الأنيميشن داخل التطبيقات. كما أستخدم أدوات التحكم في الإصدارات مثل Git، ولدي قدرة جيدة على اختبار وتصحيح التطبيقات.",
  ),
  AboutMeModel(
    icon: Icon(
      Ionicons.bulb,
      color: AppColor.darkColor,
    ),
    title: "حل المشاكل",
    content:
        "تمتع بمهارة قوية في حل المشكلات التقنية وتحليل القضايا المعقدة لإيجاد حلول فعّالة وسريعة، مما يعزز من قدرتي على التعامل مع التحديات بكفاءة.",
  ),
];
