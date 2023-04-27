import 'package:flutter/material.dart';

class SpaceCellModel {
  double height = 0;

  SpaceCellModel(this.height);
}

class SpaceCell extends StatefulWidget {
  final SpaceCellModel model;

  const SpaceCell({Key? key, required this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SpaceCellState();
  }
}

class SpaceCellState extends State<SpaceCell> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: double.infinity, height: this.widget.model.height);
  }
}
