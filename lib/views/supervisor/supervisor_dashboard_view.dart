import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:withschools/configs/colors.dart';
import 'package:withschools/widgets/cards/statistic_card_widget.dart';
import 'package:withschools/widgets/global/avatar_widget.dart';

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
        title: const Text('Accueil'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.messenger_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 0,
                child: LoadingOverlay(
                  isLoading: false,
                  child: const ListTile(
                    leading: AvatarWidget(path: 'https://i.pravatar.cc/300'),
                    title: Text('Baraeem Razzi'),
                    subtitle: Text('School'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
              ),
              //@journey's count
              SizedBox(
                height: Get.height * .14,
                child: LoadingOverlay(
                  isLoading: false,
                  child: Card(
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Voyages',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Icon(Icons.route, size: 50, color: white),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
