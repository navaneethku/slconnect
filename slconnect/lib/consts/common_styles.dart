import 'package:flutter/material.dart';
import 'package:slconnect/consts/colors.dart';

final TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontWeight: FontWeight.w500,
    fontSize: 12);

const TextStyle selectedLabelStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);
const TextStyle smallWhite = TextStyle(color: Colors.white, fontSize: 12);
const TextStyle smallWhiteBold =
    TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold);
const TextStyle mediumWhite = TextStyle(color: Colors.white, fontSize: 18);
const TextStyle mediumWhiteBold =
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle largeWhiteBold =
    TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
const TextStyle mediumPrimary = TextStyle(color: primary, fontSize: 18);
const TextStyle mediumSecondary = TextStyle(color: secondary, fontSize: 18);
const TextStyle mediumSecondaryBold =
    TextStyle(color: secondary, fontSize: 18, fontWeight: FontWeight.bold);
const TextStyle mediumPrimaryBold =
    TextStyle(color: primary, fontSize: 18, fontWeight: FontWeight.w600);
const TextStyle largePrimary = TextStyle(color: primary, fontSize: 24);
const TextStyle largeBlack = TextStyle(color: primary, fontSize: 24);
const TextStyle largePrimaryBold =
    TextStyle(color: primary, fontSize: 24, fontWeight: FontWeight.w600);
const TextStyle largePrimaryBlack =
    TextStyle(color: primary, fontSize: 24, fontWeight: FontWeight.w600);
const textStyle = TextStyle(
  color: primary,
  fontSize: 22.0,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);

final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 2,
        )));
