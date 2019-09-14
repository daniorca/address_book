import 'package:flutter/material.dart';

class AvatarFadeImage extends StatelessWidget {
  final String imageUrl;
  final double imageSize;

  AvatarFadeImage({@required this.imageUrl, @required this.imageSize});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/spinner.gif',
        image: imageUrl,
        fit: BoxFit.contain,
        width: imageSize,
      ),
    );
  }
}
