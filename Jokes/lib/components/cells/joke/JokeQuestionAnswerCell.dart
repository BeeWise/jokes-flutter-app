import 'package:flutter/material.dart';
import 'package:jokes/components/attributed_text/AttributedText.dart';
import 'package:jokes/components/buttons/ImageTitleButton.dart';
import 'package:jokes/components/views/UserAvatarView.dart';
import 'package:collection/collection.dart';
import 'package:jokes/style/ApplicationStyle.dart';

import '../../../models/image/CompoundImage.dart';
import '../../../scenes/application/ApplicationLocalization.dart';
import '../../../scenes/jokes/JokesStyle.dart' hide UserAvatarViewModel;
import '../../../style/ApplicationConstraints.dart';

class JokeQuestionAnswerCellModel {
  String? id;

  UserAvatarViewModel avatar;

  AttributedText? name;
  AttributedText? username;
  AttributedText? text;
  AttributedText? answer;
  bool isRead = false;

  ImageTitleButtonModel? likeCount;
  ImageTitleButtonModel? dislikeCount;

  AttributedText? time;

  JokeQuestionAnswerCellInterface? cellInterface;

  JokeQuestionAnswerCellModel(this.avatar);
}

abstract class JokeQuestionAnswerCellInterface {
  void reload();
}

abstract class JokeQuestionAnswerCellDelegate {
  void jokeQuestionAnswerCellOnPressLikeCount(String? id);

  void jokeQuestionAnswerCellOnPressDislikeCount(String? id);

  void jokeQuestionAnswerCellOnPressUserAvatar(String? id);

  void jokeQuestionAnswerCellOnPressUserName(String? id);

  void jokeQuestionAnswerCellOnPressReadAnswer(String? id);
}

class JokeQuestionAnswerCell extends StatefulWidget {
  final JokeQuestionAnswerCellModel model;
  final JokeQuestionAnswerCellDelegate? delegate;

  const JokeQuestionAnswerCell({Key? key, required this.model, this.delegate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JokeQuestionAnswerCellState();
  }
}

class JokeQuestionAnswerCellState extends State<JokeQuestionAnswerCell>
    with JokeQuestionAnswerCellInterface, UserAvatarViewDelegate {
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
          this.setupAnswer(),
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
    this
        .widget
        .delegate
        ?.jokeQuestionAnswerCellOnPressUserAvatar(this.widget.model.id);
  }

  Widget setupUserContainerView() {
    return InkWell(
        onTap: () {
          this
              .widget
              .delegate
              ?.jokeQuestionAnswerCellOnPressUserName(this.widget.model.id);
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

  Widget setupAnswer() {
    if (this.widget.model.isRead) {
      return this.setupAnswerText();
    } else {
      return this.setupAnswerButton();
    }
  }

  Widget setupAnswerButton() {
    final title = AttributedText(
        ApplicationLocalization.instance.readAnswerTitle(),
        JokesStyle.instance.jokeCellModel.answerButtonStyle);
    title.align = TextAlign.center;
    final model = ImageTitleButtonModel();
    model.image = CompoundImage(
        null, ApplicationStyle.images.answerSmallImage, BoxFit.contain);
    model.isDisabled = false;
    model.backgroundImage = CompoundImage(
        null, ApplicationStyle.images.buttonBackgroundImage, BoxFit.cover);
    model.borderRadius = ApplicationConstraints.constant.x16;
    model.borderColor = ApplicationStyle.colors.white;
    model.backgroundColor = ApplicationStyle.colors.primary;
    model.title = title;
    return Container(
        height: ApplicationConstraints.constant.x32,
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: ImageTitleButton(model: model, onPress: () => { this.widget.delegate?.jokeQuestionAnswerCellOnPressReadAnswer(this.widget.model.id) }));
  }

  Widget setupAnswerText() {
    return Container(
        margin: EdgeInsets.only(
            left: ApplicationConstraints.constant.x16,
            right: ApplicationConstraints.constant.x16),
        child: Text(this.widget.model.answer?.text ?? "",
            textAlign: this.widget.model.answer?.align,
            overflow: this.widget.model.answer?.overflow,
            style: this.widget.model.answer?.style));
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
                this.widget.delegate?.jokeQuestionAnswerCellOnPressLikeCount(
                    this.widget.model.id);
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
                this.widget.delegate?.jokeQuestionAnswerCellOnPressDislikeCount(
                    this.widget.model.id);
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
