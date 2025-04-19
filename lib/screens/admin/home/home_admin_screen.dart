import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_color.dart';
import '../../../models/bottom_navigation_model.dart';
import 'controller/home_admin_controller.dart';
import 'widgets/home_nav_icon.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeAdminController());
    return Scaffold(
      body: GetBuilder<HomeAdminController>(
        builder: (controller) => PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation, secondAnimation) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondAnimation,
              child: child,
            );
          },
          child: controller.pages.elementAt(controller.currentPage),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        child: Container(
          decoration: BoxDecoration(color: AppColor.white, boxShadow: [
            BoxShadow(
              color: AppColor.grey.withValues(alpha: 0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ]),
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder<HomeAdminController>(
            builder: (controller) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.bottomNavigations.length,
                (index) {
                  BottomNavigationModel icon =
                      controller.bottomNavigations[index];
                  return HomeNavIcon(
                    icon: icon,
                    index: index,
                    currentPage: controller.currentPage,
                    onTap: () => controller.onPageChanged(index),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
