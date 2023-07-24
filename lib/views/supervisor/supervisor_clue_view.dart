import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:withschools/views/supervisor/supervisor_dashboard_view.dart';
import 'package:withschools/views/supervisor/supervisor_journey_view.dart';
//VIEW's

//CONTROLLER's
import '/controllers/supervisor_clue_controller.dart';

class SupervisorClueView extends StatefulWidget {
  const SupervisorClueView({Key? key}) : super(key: key);

  @override
  State<SupervisorClueView> createState() => _SupervisorClueViewState();
}

class _SupervisorClueViewState extends State<SupervisorClueView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupervisorClueController>(
      builder: (supervisorClueController) {
        return Scaffold(
          key: supervisorClueController.scaffoldKey,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: IndexedStack(
            index: supervisorClueController.tabIndex,
            children: const [
              SupervisorDashboardView(),
              SupervisorJourneyView(),
              Text('Dasbhoard'),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: supervisorClueController.changeTabIndex,
            currentIndex: supervisorClueController.tabIndex,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            elevation: 10,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded, size: 30),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/app/ws-logo.svg',
                  height: 35.0,
                  width: 35.0,
                  allowDrawingOutsideViewBox: true,
                ),
                label: 'Voyage',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined, size: 30),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
