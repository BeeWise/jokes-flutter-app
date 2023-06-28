import 'package:flutter/material.dart';
import '../../../style/ApplicationStyle.dart';
import '../../style/ApplicationConstraints.dart';

class JokesStyle {
  static final instance = JokesStyle();

  ContentViewModel contentViewModel = ContentViewModel();
  UserAvatarViewModel userAvatarViewModel = UserAvatarViewModel();
  CellModel cellModel = CellModel();
  ListViewModel listViewModel = ListViewModel();
  JokeCellModel jokeCellModel = JokeCellModel();
}

class ContentViewModel {
  Color backgroundColor = ApplicationStyle.colors.backgroundColor;
}

class UserAvatarViewModel {
  String placeholder = ApplicationStyle.images.userAvatarPlaceholderSmallImage;
  double borderRadius = ApplicationConstraints.constant.x20;
  Color backgroundColor = ApplicationStyle.colors.transparent;
  Color borderColor = ApplicationStyle.colors.white.withAlpha(127);
  double borderWidth = ApplicationConstraints.constant.x1;
  double margin = ApplicationConstraints.constant.x0;
  Color activityIndicatorColor = ApplicationStyle.colors.white;
}

class CellModel {
  Color backgroundColor = ApplicationStyle.colors.transparent;
}

class ListViewModel {
  Color activityIndicatorColor = ApplicationStyle.colors.primary;

  TextStyle noMoreItemsTextStyle = TextStyle(color: ApplicationStyle.colors.gray, fontFamily: ApplicationStyle.fonts.regular, fontSize: 14);

  TextStyle errorTextStyle = TextStyle(color: ApplicationStyle.colors.secondary, fontFamily: ApplicationStyle.fonts.regular, fontSize: 14);
}

class JokeCellModel {
  double avatarBorderRadius = ApplicationConstraints.constant.x20;
  Color avatarActivityColor = ApplicationStyle.colors.primary;
  Color avatarBackgroundColor = ApplicationStyle.colors.transparent;
  Color avatarBorderColor = ApplicationStyle.colors.white.withAlpha(127);
  double avatarBorderWidth = ApplicationConstraints.constant.x1;
  double avatarMargin = ApplicationConstraints.constant.x0;
  String avatarPlaceholder = ApplicationStyle.images.userAvatarPlaceholderSmallImage;

  TextStyle nameStyle = TextStyle(color: ApplicationStyle.colors.primary, fontFamily: ApplicationStyle.fonts.bold, fontSize: 17, fontWeight: FontWeight.bold);
  TextStyle usernameStyle = TextStyle(color: ApplicationStyle.colors.gray, fontFamily: ApplicationStyle.fonts.regular, fontSize: 14);
  TextStyle textStyle = TextStyle(color: ApplicationStyle.colors.primary, fontFamily: ApplicationStyle.fonts.regular, fontSize: 17);
  TextStyle answerStyle = TextStyle(color: ApplicationStyle.colors.primary, fontFamily: ApplicationStyle.fonts.regular, fontSize: 17);
  TextStyle answerButtonStyle = TextStyle(color: ApplicationStyle.colors.white, fontFamily: ApplicationStyle.fonts.regular, fontSize: 17);

  Color likeCountActivityColor = ApplicationStyle.colors.gray;
  String likeCountImage = ApplicationStyle.images.likeSmallImage;
  Color unselectedLikeCountBackgroundColor = ApplicationStyle.colors.transparent;
  Color unselectedLikeCountTintColor = ApplicationStyle.colors.gray;
  TextStyle unselectedLikeCountStyle = TextStyle(color: ApplicationStyle.colors.gray, fontFamily: ApplicationStyle.fonts.regular, fontSize: 16);

  Color dislikeCountActivityColor = ApplicationStyle.colors.primary;
  String dislikeCountImage = ApplicationStyle.images.dislikeSmallImage;
  Color unselectedDislikeCountBackgroundColor = ApplicationStyle.colors.transparent;
  Color unselectedDislikeCountTintColor = ApplicationStyle.colors.gray;
  TextStyle unselectedDislikeCountStyle = TextStyle(color: ApplicationStyle.colors.gray, fontFamily: ApplicationStyle.fonts.regular, fontSize: 16);

  TextStyle timeStyle = TextStyle(color: ApplicationStyle.colors.gray, fontFamily: ApplicationStyle.fonts.oblique, fontSize: 13, fontStyle: FontStyle.italic);
}