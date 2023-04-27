import 'package:flutter/material.dart';
import 'package:jokes/components/attributed_text/AttributedText.dart';
import 'package:jokes/components/buttons/ImageTitleButton.dart';
import 'package:jokes/components/views/UserAvatarView.dart';
import 'package:collection/collection.dart';
import 'package:jokes/style/ApplicationStyle.dart';

import '../../../style/ApplicationConstraints.dart';

class JokeTextCellModel {
  String? id;

  UserAvatarViewModel avatar;

  AttributedText? name;
  AttributedText? username;
  AttributedText? text;

  ImageTitleButtonModel? likeCount;
  ImageTitleButtonModel? dislikeCount;

  AttributedText? time;

  JokeTextCellInterface? cellInterface;

  JokeTextCellModel(this.avatar);
}

abstract class JokeTextCellInterface {
  void reload();
}

abstract class JokeTextCellDelegate {
  void jokeTextCellOnPressLikeCount(String? id);

  void jokeTextCellOnPressDislikeCount(String? id);

  void jokeTextCellOnPressUserAvatar(String? id);

  void jokeTextCellOnPressUserName(String? id);
}

class JokeTextCell extends StatefulWidget {
  final JokeTextCellModel model;
  final JokeTextCellDelegate? delegate;

  const JokeTextCell({Key? key, required this.model, this.delegate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JokeTextCellState();
  }
}

class JokeTextCellState extends State<JokeTextCell>
    with JokeTextCellInterface, UserAvatarViewDelegate {
  @override
  void reload() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this.widget.model.cellInterface = this;
    return this.setupContentView();
  }

  Widget setupContentView() {
    return IntrinsicHeight(child: this.setupContainerView());
  }

  Widget setupContainerView() {
    return Container(
        decoration: BoxDecoration(
            color: ApplicationStyle.colors.white,
            borderRadius:
                BorderRadius.circular(ApplicationConstraints.constant.x16),
            border: Border.all(
                color: ApplicationStyle.colors.lightGray,
                width: ApplicationConstraints.constant.x1)),
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          this.setupVerticalSpaceView(ApplicationConstraints.constant.x16),
          this.setupTopContainerView(),
          this.setupVerticalSpaceView(ApplicationConstraints.constant.x16),
          this.setupText(),
          this.setupVerticalSpaceView(ApplicationConstraints.constant.x16),
          this.setupBottomContainerView(),
          this.setupVerticalSpaceView(ApplicationConstraints.constant.x16)
        ]));
  }

  Widget setupTopContainerView() {
    return Container(
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: Row(children: [
          this.setupUserAvatarView(),
          this.setupHorizontalSpaceView(
              ApplicationConstraints.constant.x8, false),
          this.setupUserContainerView(),
          this.setupHorizontalSpaceView(
              ApplicationConstraints.constant.x8, false)
        ]));
  }

  Widget setupUserAvatarView() {
    return SizedBox(
        width: ApplicationConstraints.constant.x40,
        height: ApplicationConstraints.constant.x40,
        child: UserAvatarView(model: this.widget.model.avatar, delegate: this));
  }

  @override
  void userAvatarViewOnPress() {
    this.widget.delegate?.jokeTextCellOnPressUserAvatar(this.widget.model.id);
  }

  Widget setupUserContainerView() {
    return InkWell(
        onTap: () {
          this
              .widget
              .delegate
              ?.jokeTextCellOnPressUserName(this.widget.model.id);
        },
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [this.setupName(), this.setupUsername()]));
  }

  Widget setupName() {
    return Text(this.widget.model.name?.text ?? "",
        textAlign: this.widget.model.name?.align,
        overflow: this.widget.model.name?.overflow,
        style: this.widget.model.name?.style);
  }

  Widget setupUsername() {
    return Text(this.widget.model.username?.text ?? "",
        textAlign: this.widget.model.username?.align,
        overflow: this.widget.model.username?.overflow,
        style: this.widget.model.username?.style);
  }

  Widget setupText() {
    return Container(
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: Text(this.widget.model.text?.text ?? "",
            textAlign: this.widget.model.text?.align,
            overflow: this.widget.model.text?.overflow,
            style: this.widget.model.text?.style));
  }

  Widget setupBottomContainerView() {
    return Container(
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: Row(
            children: [
          this.setupLikeCountView(),
          this.setupHorizontalSpaceView(
              ApplicationConstraints.constant.x8, false),
          this.setupDislikeCountView(),
          this.setupHorizontalSpaceView(
              ApplicationConstraints.constant.x8, true),
          this.setupTime()
        ].whereNotNull().toList()));
  }

  Widget? setupLikeCountView() {
    final model = this.widget.model.likeCount;
    if (model != null) {
      return SizedBox(
          height: ApplicationConstraints.constant.x24,
          child: ImageTitleButton(
              model: model,
              onPress: () {
                this
                    .widget
                    .delegate
                    ?.jokeTextCellOnPressLikeCount(this.widget.model.id);
              }));
    }
    return null;
  }

  Widget? setupDislikeCountView() {
    final model = this.widget.model.dislikeCount;
    if (model != null) {
      return SizedBox(
          height: ApplicationConstraints.constant.x24,
          child: ImageTitleButton(
              model: model,
              onPress: () {
                this
                    .widget
                    .delegate
                    ?.jokeTextCellOnPressDislikeCount(this.widget.model.id);
              }));
    }
    return null;
  }

  Widget setupTime() {
    return Text(this.widget.model.time?.text ?? "",
        textAlign: this.widget.model.time?.align,
        overflow: this.widget.model.time?.overflow,
        style: this.widget.model.time?.style);
  }

  Widget setupVerticalSpaceView(double height) {
    return SizedBox(height: height);
  }

  Widget setupHorizontalSpaceView(double width, bool shouldFlex) {
    if (shouldFlex) {
      return Expanded(flex: 1, child: Container());
    }
    return SizedBox(width: width);
  }
}
