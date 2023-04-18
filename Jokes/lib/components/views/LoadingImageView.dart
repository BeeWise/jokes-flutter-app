import 'package:flutter/material.dart';
import 'package:jokes/models/image/CompoundImage.dart';

class LoadingImageViewModel {
  double? borderTopRightRadius;
  double? borderTopLeftRadius;
  double? borderBottomRightRadius;
  double? borderBottomLeftRadius;

  bool isLoading;
  Color? activityIndicatorColor;
  Color? imageBackgroundColor;
  CompoundImage image;

  LoadingImageViewModel(this.image, this.isLoading);
}

class LoadingImageView extends StatefulWidget {
  final LoadingImageViewModel model;

  const LoadingImageView({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingImageViewState();
  }
}

class LoadingImageViewState extends State<LoadingImageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(
            minWidth: double.infinity, minHeight: double.infinity),
        child: this.setupContainerView());
  }

  Widget setupContainerView() {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft:
                Radius.circular(this.widget.model.borderTopLeftRadius ?? 0),
            topRight:
                Radius.circular(this.widget.model.borderTopRightRadius ?? 0),
            bottomLeft:
                Radius.circular(this.widget.model.borderBottomLeftRadius ?? 0),
            bottomRight: Radius.circular(
                this.widget.model.borderBottomRightRadius ?? 0)),
        child: Container(
            color: this.widget.model.imageBackgroundColor,
            child: this.setupImageView()));
  }

  Widget? setupImageView() {
    final uri = this.widget.model.image.uri;
    final asset = this.widget.model.image.asset;

    if (uri != null) {
      return Image.network(uri, fit: this.widget.model.image.fit, loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return this.setupActivityIndicator();
      });
    } else if (asset != null) {
      return Image.asset(asset, fit: this.widget.model.image.fit);
    }
    return null;
  }

  Widget setupActivityIndicator() {
    return Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
            color: this.widget.model.activityIndicatorColor));
  }
}
