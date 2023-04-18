import 'package:flutter/material.dart';

class ApplicationStyle {
  static final fonts = ApplicationFonts();
  static final colors = ApplicationColors();
  static final images = ApplicationImages();
}

class ApplicationFonts {
  String get regular { return "Helvetica"; }
  String get bold { return "Helvetica-Bold"; }
  String get boldOblique { return "Helvetica-BoldOblique"; }
  String get light { return "Helvetica-Light"; }
  String get oblique { return "Helvetica-Oblique"; }
}

class ApplicationColors {
  Color get white { return const Color(0xFFFFFFFF); }
  get black { return const Color(0xFF000000); }
  get primary { return const Color(0xFF201D2E); }
  get secondary { return const Color(0xFFBC2753); }
  get lightPrimary { return const Color(0xFF6FE9ED); }
  get lightPrimaryShade15 { return const Color(0x6FE9ED4D); }
  get lightSecondary { return const Color(0xFFE64E7A); }
  get lightSecondaryShade15 { return const Color(0xE64E7A4D); }
  get transparent { return Colors.transparent; }
  get gray { return const Color(0xFF697882); }
  get lightGray { return const Color(0xFFE1E8ED); }
  get backgroundColor { return const Color(0xFFFFFFFF); }
  get neonDarkGreen { return const Color(0xFF20CC00); }
  get neonOrange { return const Color(0xFFFBB23F); }
  get neonPurple { return const Color(0xFFE64E7A); }
}

class ApplicationImages {
  String get dislikeSmallImage { return "lib/resources/images/dislike_small_image.png"; }
  String get likeSmallImage { return "lib/resources/images/like_small_image.png"; }

  String get userAvatarPlaceholderSmallImage { return "lib/resources/images/user_avatar_placeholder_small_image.png"; }

  String get answerSmallImage { return "lib/resources/images/answer_small_image.png"; }
  String get buttonBackgroundImage { return "lib/resources/images/button_wall_background_image.png"; }

  String get backArrowSmallImage { return "lib/resources/images/back_arrow_small_image.png"; }
  String get neonLogoMediumImage { return "lib/resources/images/neon_medium_logo_image.png"; }

  String get wallBackgroundImage { return "lib/resources/images/wall_background_image.png"; }
}