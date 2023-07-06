// ignore_for_file: avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'Viewonly3dModel.dart';

class ViewItemAR extends StatelessWidget {
  final ImagePath;
  final renderImage;

  const ViewItemAR(
      {Key? key, required this.ImagePath, required this.renderImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: ImagePath,
            placeholder: (context, url) => const Center(
              child: SpinKitFadingCircle(
                color: Colors.red,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300.0,
          ),
          Positioned(
              bottom: 10.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  Get.to(ViewOnly3DModel(
                    render_image: renderImage,
                  ));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.cyan,
                  radius: 23.0,
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "images/AR.svg",
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
