import 'package:flutter/material.dart';

class AttributedText {
  String? text;
  TextStyle style;
  TextAlign? align = TextAlign.start;
  TextOverflow? overflow;

  AttributedText(this.text, this.style);
}
