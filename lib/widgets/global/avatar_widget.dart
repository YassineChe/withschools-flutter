import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
//Configs
import '/configs/colors.dart';

class AvatarWidget extends StatelessWidget {
  final String? path;
  final double raduis;
  final double width;
  final double height;
  final Color borderColor;
  final double elevation;
  final double borderWidth;
  final bool viewer;

  const AvatarWidget({
    Key? key,
    this.path,
    this.width = 25,
    this.height = 25,
    this.raduis = 25,
    this.elevation = 5,
    this.borderColor = white,
    this.borderWidth = 0,
    this.viewer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProfileAvatar(
      path ?? '',
      errorWidget: (context, url, error) {
        return const Icon(Icons.image_not_supported_outlined);
      },
      placeHolder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: const CircularProgressIndicator(),
      ),
      borderColor: borderColor,
      borderWidth: borderWidth,
      onTap: () {
        if (path != null && viewer) {
          showImageViewer(
            context,
            Image.network(
              path ?? '',
            ).image,
          );
        }
      },
      radius: raduis,
      elevation: elevation,
    );
  }
}
