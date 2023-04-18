import 'package:flutter/material.dart';
import 'package:jokes/models/image/CompoundImage.dart';
import '../../style/ApplicationConstraints.dart';
import '../../style/ApplicationStyle.dart';
import '../attributed_text/AttributedText.dart';

class LoadingButtonModel {
  AttributedText? title;
  double borderRadius = ApplicationConstraints.constant.x24;
  double borderWidth = 0.0;
  bool isLoading = false;
  bool isDisabled = false;
  Color borderColor = ApplicationStyle.colors.primary;
  Color activityIndicatorColor = ApplicationStyle.colors.white;
  Color backgroundColor = ApplicationStyle.colors.primary;
  CompoundImage? backgroundImage;
  Color shadowColor = ApplicationStyle.colors.primary;
  double opacity = 1.0;
}

class LoadingButton extends StatefulWidget {
  final LoadingButtonModel model;
  final VoidCallback? onPress;

  const LoadingButton({Key? key, required this.model, this.onPress})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingButtonState();
  }
}

class LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: Opacity(
            opacity: this.widget.model.opacity, child: this.setupButton()));
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
        child: this.setupContentView());
  }

  onPress() {
    if (this.widget.onPress == null) return;
    if (this.widget.model.isDisabled) return;
    if (this.widget.model.isLoading) return;
    this.widget.onPress!();
  }

  Widget setupContentView() {
    List<Widget> children = [];
    if (this.widget.model.backgroundImage != null) {
      children.add(this.setupImageBackground());
    }
    if (this.widget.model.isLoading) {
      children.add(this.setupActivityIndicator());
    } else {
      children.add(this.setupTitle());
    }
    return Stack(
        fit: StackFit.expand, clipBehavior: Clip.none, children: children);
  }

  Widget setupImageBackground() {
    final uri = this.widget.model.backgroundImage?.uri;
    final asset = this.widget.model.backgroundImage?.asset;

    if (uri != null) {
      return Image.network(uri, fit: this.widget.model.backgroundImage?.fit);
    } else if (asset != null) {
      return Image.asset(asset, fit: this.widget.model.backgroundImage?.fit);
    }
    return Container();
  }

  Widget setupTitle() {
    return SizedBox(
        width: double.infinity,
        child: Align(
            alignment: Alignment.center,
            child: Text(this.widget.model.title?.text ?? "",
                textAlign: this.widget.model.title?.align,
                overflow: this.widget.model.title?.overflow,
                style: this.widget.model.title?.style)));
  }

  Widget setupActivityIndicator() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = constraints.maxHeight * ApplicationConstraints.multiplier.x62;
      return Center(child: SizedBox(width: size, height: size, child: CircularProgressIndicator(
          color: this.widget.model.activityIndicatorColor)));
    });
  }
}
