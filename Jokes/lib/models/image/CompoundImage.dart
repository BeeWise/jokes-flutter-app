import 'package:flutter/material.dart';

class CompoundImage {
  String? uri;
  String? asset;
  BoxFit fit = BoxFit.cover;

  CompoundImage(this.uri, this.asset, this.fit);
}