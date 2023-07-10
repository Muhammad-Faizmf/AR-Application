// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_model_viewer/flutter_model_viewer.dart';
import 'package:login_flutter/widgets/gestureOnPlane.dart';

class ViewOnly3DModel extends StatefulWidget {
  final render_image;
  const ViewOnly3DModel({Key? key, required this.render_image})
      : super(key: key);

  @override
  State<ViewOnly3DModel> createState() => _ViewOnly3DModelState();
}

class _ViewOnly3DModelState extends State<ViewOnly3DModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
          body: Stack(
        children: [
          ModelViewer(
            src: widget.render_image,
            autoRotate: false,
            autoPlay: false,
            cameraControls: true,
            openCache: true,
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ObjectGesturesWidget(
                              imageObject: widget.render_image,
                            )),
                  );
                },
                child: const Text("View In AR")),
          )
        ],
      )),
    );
  }
}
