
// ignore_for_file: avoid_unnecessary_containers


import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ViewOnly3DModel extends StatefulWidget {
  final render_image;
  const ViewOnly3DModel({ Key? key, required this.render_image }) : super(key: key);

  @override
  State<ViewOnly3DModel> createState() => _ViewOnly3DModelState();
}

class _ViewOnly3DModelState extends State<ViewOnly3DModel> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ModelViewer(
          src: widget.render_image,
          ar: true,
          autoRotate: true,
          cameraControls: true,
          arPlacement: ArPlacement.floor,
        ),
      )
    );
  }
  
}