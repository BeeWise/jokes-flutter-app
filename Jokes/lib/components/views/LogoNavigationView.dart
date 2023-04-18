import 'package:flutter/material.dart';
import 'package:jokes/components/views/UserAvatarView.dart';
import 'package:jokes/style/ApplicationConstraints.dart';
import 'package:jokes/style/ApplicationStyle.dart';

class LogoNavigationViewModel {
  bool includeBack = false;
  bool includeUserAvatar = false;
  bool includeSeparator = false;
  UserAvatarViewModel userAvatar;

  LogoNavigationViewModel(this.userAvatar);
}

abstract class LogoNavigationViewDelegate {
  void logoNavigationViewOnPressBackButton();

  void logoNavigationViewOnPressLogoImage();

  void logoNavigationViewOnPressUserAvatar();
}

class LogoNavigationView extends StatefulWidget {
  final LogoNavigationViewModel model;
  final LogoNavigationViewDelegate? delegate;

  const LogoNavigationView({Key? key, required this.model, this.delegate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LogoNavigationViewState();
  }
}

class LogoNavigationViewState extends State<LogoNavigationView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ApplicationConstraints.navigationBarHeight, child: this.setupContainerView());
  }

  Widget setupContainerView() {
    List<Widget> children = [];
    if (this.widget.model.includeBack) {
      children.add(this.setupBackButton());
    }
    children.add(this.setupLogoImageView());
    if (this.widget.model.includeUserAvatar) {
      children.add(this.setupUserAvatarView());
    }
    if (this.widget.model.includeSeparator) {
      children.add(this.setupSeparatorView());
    }
    return Stack(alignment: Alignment.center, children: children);
  }

  Widget setupBackButton() {
    return Positioned(
        left: 0,
        child: Container(
            margin: EdgeInsets.only(right: ApplicationConstraints.constant.x16),
            width: ApplicationConstraints.constant.x40,
            height: ApplicationConstraints.constant.x40,
            child: IconButton(
                onPressed: () {
                  this.widget.delegate?.logoNavigationViewOnPressBackButton();
                },
                icon:
                    Image.asset(ApplicationStyle.images.backArrowSmallImage))));
  }

  Widget setupLogoImageView() {
    return InkWell(child: LayoutBuilder(builder: (context, constraints) {
      return Align(
          alignment: Alignment.center,
          child: Image.asset(ApplicationStyle.images.neonLogoMediumImage,
              height: constraints.maxHeight *
                  ApplicationConstraints.multiplier.x75));
    }), onTap: () => { this.widget.delegate?.logoNavigationViewOnPressLogoImage() });
  }

  Widget setupUserAvatarView() {
    return InkWell(child: Positioned(
        right: 0,
        child: Container(
            margin: EdgeInsets.only(right: ApplicationConstraints.constant.x16),
            width: ApplicationConstraints.constant.x40,
            height: ApplicationConstraints.constant.x40,
            child: UserAvatarView(model: this.widget.model.userAvatar))), onTap: () => { this.widget.delegate?.logoNavigationViewOnPressUserAvatar() });
  }

  Widget setupSeparatorView() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: ApplicationConstraints.constant.x1,
        child: Container(color: ApplicationStyle.colors.white));
  }
}
