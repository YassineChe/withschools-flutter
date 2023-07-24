import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:withschools/configs/colors.dart';
import 'package:withschools/widgets/cards/statistic_card_widget.dart';

class SupervisorDashboardView extends StatefulWidget {
  const SupervisorDashboardView({super.key});

  @override
  State<SupervisorDashboardView> createState() => _SupervisorDashboardViewState();
}

class _SupervisorDashboardViewState extends State<SupervisorDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dasbhoard'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StatisticCardWidget(
                      title: '100',
                      subtitle: 'Voyages',
                      icon: Icons.route,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
