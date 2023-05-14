import 'package:flutter/material.dart';
import 'package:slconnect/consts/colors.dart';

final TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.w500,
    fontSize: 12);

const TextStyle selectedLabelStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

const TextStyle mediumWhite = TextStyle(color: Colors.white, fontSize: 18);
const TextStyle mediumPrimary = TextStyle(color: primary, fontSize: 18);
const TextStyle mediumPrimaryBold =
    TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.w600);
const TextStyle largePrimary = TextStyle(color: primary, fontSize: 24);
const TextStyle largePrimaryBold = TextStyle(color: primary, fontSize: 24, fontWeight: FontWeight.w600);
