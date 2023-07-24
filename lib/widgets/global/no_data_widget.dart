import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:withschools/configs/colors.dart';

class NoDataWidget extends StatelessWidget {
  //Title
  final String? asset;
  final String? hint;
  final String? subHint;
  final String? buttonText;
  final VoidCallback? onPress;
  //Constructor
  const NoDataWidget({
    Key? key,
    @required this.hint,
    this.subHint,
    this.onPress,
    this.buttonText,
    this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //@ SVG ----------------------------------
          SvgPicture.asset(
            asset ?? 'assets/svg/no-data.svg',
            width: Get.height * .2,
          ),
          //@ SPACING ----------------------------------
          SizedBox(height: Get.height * .03),
          //@TEXT ----------------------------------
          Text(
            hint?.toUpperCase() ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          //@ SUB TITLE ----------------------------
          if (subHint != null) ...[
            SizedBox(height: Get.height * .01),
            Text(
              subHint ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            //@ SPACING ----------------------------------
            SizedBox(height: Get.height * .02),
          ],
          //@ BUTTON ----------------------------
          if (onPress != null || buttonText != null)
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(width: 1.0, color: primary),
                ), // Set the border color
                minimumSize: MaterialStateProperty.all(Size(Get.width / 1.5, 45)),
              ),
              onPressed: onPress,
              child: Text(buttonText!),
            ),
        ],
      ),
    );
  }
}
