import 'package:flutter/material.dart';

class ImgDimension {
  static double calcWidth({required String imgLoc}) {
    double imageWidth = 0;

    Image image = Image.asset(imgLoc);
    image.image.resolve(ImageConfiguration()).addListener(
          (ImageStreamListener((imageInfo, _) {
            // Calculate the width of the image size
            imageWidth = imageInfo.image.width.toDouble();
          })),
        );

    return imageWidth;
  }

  static double calcHeight({required String imgLoc}) {
    double imageHeight = 0;

    Image image = Image.asset(imgLoc);
    image.image.resolve(ImageConfiguration()).addListener(
          (ImageStreamListener((imageInfo, _) {
            // Calculate the height of the image size
            imageHeight = imageInfo.image.height.toDouble();
          })),
        );

    return imageHeight;
  }
}
