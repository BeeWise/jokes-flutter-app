import 'package:flutter/material.dart';
import '../../models/image/CompoundImage.dart';
import '../../style/ApplicationConstraints.dart';
import '../../style/ApplicationStyle.dart';
import '../attributed_text/AttributedText.dart';

class ImageTitleButtonModel {
  AttributedText? title;
  double borderRadius = ApplicationConstraints.constant.x4;
  double borderWidth = 0.0;
  bool isLoading = false;
  bool isDisabled = false;
  Color borderColor = ApplicationStyle.colors.primary;
  Color activityIndicatorColor = ApplicationStyle.colors.white;
  Color backgroundColor = ApplicationStyle.colors.primary;
  CompoundImage? image;
  Color? imageTintColor;
  CompoundImage? backgroundImage;
  double opacity = 1.0;
  ImageTitleButtonViewInterface? viewInterface;
}

abstract class ImageTitleButtonViewInterface {
  void reload();
}

class ImageTitleButton extends StatefulWidget {
  final ImageTitleButtonModel model;
  final VoidCallback? onPress;

  const ImageTitleButton({Key? key, required this.model, this.onPress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ImageTitleButtonState();
  }
}

class ImageTitleButtonState extends State<ImageTitleButton>
    with ImageTitleButtonViewInterface {
  @override
  void reload() {
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    this.widget.model.viewInterface = this;
    return Opacity(
        opacity: this.widget.model.opacity, child: this.setupButton());
  }

  Widget setupButton() {
    return Container(
        decoration: BoxDecoration(
            color: this.widget.model.backgroundColor,
            borderRadius: BorderRadius.circular(this.widget.model.borderRadius),
            border: this.widget.model.borderWidth != 0 ? Border.all(
                color: this.widget.model.borderColor,
                width: this.widget.model.borderWidth) : null),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(this.widget.model.borderRadius),
            child: this.setupInkWell()));
  }

  Widget setupInkWell() {
    return InkWell(
        onTap: () {
          this.onPress();
        },
        child: this.setupContainerView());
  }

  onPress() {
    if (this.widget.onPress == null) return;
    if (this.widget.model.isDisabled) return;
    if (this.widget.model.isLoading) return;
    this.widget.onPress!();
  }

  Widget setupImageBackground() {
    final uri = this.widget.model.backgroundImage?.uri;
    final asset = this.widget.model.backgroundImage?.asset;

    if (uri != null) {
      return FractionallySizedBox(widthFactor: 1, heightFactor: 1, child: Image.network(uri, fit: this.widget.model.backgroundImage?.fit));
    } else if (asset != null) {
      return FractionallySizedBox(widthFactor: 1, heightFactor: 1, child: Image.asset(asset, fit: this.widget.model.backgroundImage?.fit));
    }
    return Container();
  }

  Widget setupContainerView() {
    List<Widget> children = [];
    if (this.widget.model.backgroundImage != null) {
      children.add(this.setupImageBackground());
    }
    children.add(this.setupContentView());
    return Stack(children: children);
  }

  Widget setupContentView() {
    if (this.widget.model.isLoading) {
      return this.setupActivityIndicator();
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [this.setupImageView(), this.setupTitle()]);
  }

  Widget setupImageView() {
    return FractionallySizedBox(
        heightFactor: ApplicationConstraints.multiplier.x62,
        child: Container(
            margin:
            EdgeInsets.only(left: ApplicationConstraints.constant.x10),
            child: AspectRatio(aspectRatio: 1, child: this.setupImage())));
  }

  Widget? setupImage() {
    final uri = this.widget.model.image?.uri;
    final asset = this.widget.model.image?.asset;

    if (uri != null) {
      return Image.network(uri,
          color: this.widget.model.imageTintColor,
          fit: this.widget.model.image?.fit);
    } else if (asset != null) {
      return Image.asset(asset,
          color: this.widget.model.imageTintColor,
          fit: this.widget.model.image?.fit);
    }
    return null;
  }

  Widget setupTitle() {
    return Align(
        alignment: Alignment.center,
        child: Container(
            margin: EdgeInsets.only(
                left: ApplicationConstraints.constant.x10,
                right: ApplicationConstraints.constant.x10),
            child: Text(this.widget.model.title?.text ?? "",
                textAlign: this.widget.model.title?.align,
                overflow: this.widget.model.title?.overflow,
                style: this.widget.model.title?.style)));
  }

  Widget setupActivityIndicator() {
    return LayoutBuilder(builder: (context, constraints) {
      final size =
          constraints.maxHeight * ApplicationConstraints.multiplier.x50;
      return Center(
          child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                  color: this.widget.model.activityIndicatorColor)));
    });
  }
}
