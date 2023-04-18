import 'package:flutter/material.dart';
import 'package:jokes/components/views/LoadingImageView.dart';
import '../../style/ApplicationConstraints.dart';

class UserAvatarViewModel {
  bool isDisabled = false;
  Color? backgroundColor;
  Color? borderColor;
  double? borderWidth;
  LoadingImageViewModel loadingImage;
  double margin = ApplicationConstraints.constant.x0;

  UserAvatarViewModel(this.loadingImage);
}

abstract class UserAvatarViewDelegate {
  void userAvatarViewOnPress();
}

class UserAvatarView extends StatefulWidget {
  final UserAvatarViewModel model;
  final UserAvatarViewDelegate? delegate;

  const UserAvatarView({Key? key, required this.model, this.delegate}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UserAvatarViewState();
  }
}

class UserAvatarViewState extends State<UserAvatarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
            minWidth: double.infinity, minHeight: double.infinity),
        child: IgnorePointer(
            ignoring: this.widget.model.isDisabled,
            child: InkWell(
                child: this.setupContainerView(),
                onTap: () {
                  this.widget.delegate?.userAvatarViewOnPress();
                })));
  }

  Widget setupContainerView() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                this.widget.model.loadingImage.borderTopLeftRadius ?? 0),
            topRight: Radius.circular(
                this.widget.model.loadingImage.borderTopRightRadius ?? 0),
            bottomLeft: Radius.circular(
                this.widget.model.loadingImage.borderBottomLeftRadius ?? 0),
            bottomRight: Radius.circular(
                this.widget.model.loadingImage.borderBottomRightRadius ?? 0)),
        child: this.setupImageView());
  }

  Widget? setupImageView() {
    return Container(
        margin: EdgeInsets.all(this.widget.model.margin),
        decoration: BoxDecoration(
            color: this.widget.model.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                    this.widget.model.loadingImage.borderTopLeftRadius ?? 0),
                topRight: Radius.circular(
                    this.widget.model.loadingImage.borderTopRightRadius ?? 0),
                bottomLeft: Radius.circular(
                    this.widget.model.loadingImage.borderBottomLeftRadius ?? 0),
                bottomRight: Radius.circular(
                    this.widget.model.loadingImage.borderBottomRightRadius ?? 0)),
            border: this.widget.model.borderWidth != 0 ? Border.all(
                color: this.widget.model.borderColor ?? Colors.transparent,
                width: this.widget.model.borderWidth ?? 0) : null),
        child: LoadingImageView(model: this.widget.model.loadingImage));
  }
}
