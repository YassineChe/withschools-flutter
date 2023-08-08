import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticCardWidget extends StatelessWidget {
  final String? subtitle;
  final String? title;
  final IconData? icon;
  final bool? isLoading;

  const StatisticCardWidget({
    Key? key,
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .14,
      child: LoadingOverlay(
        isLoading: isLoading ?? false,
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$subtitle'.toUpperCase(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '$title',
                    style: Theme.of(context).textTheme.headlineLarge,
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon),
              )
            ],
          ),
        ),
      ),
    );
  }
}
