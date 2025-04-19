import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../constants/app_color.dart';
import '../../../../models/bottom_navigation_model.dart';

class HomeNavIcon extends StatelessWidget {
  const HomeNavIcon({
    super.key,
    required this.icon,
    required this.currentPage,
    required this.index,
    required this.onTap,
  });

  final BottomNavigationModel icon;
  final int currentPage, index;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color:
                  currentPage == index ? AppColor.primary : Colors.transparent,
              width: 5,
              style: BorderStyle.solid,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon.icon,
              colorFilter: ColorFilter.mode(
                  currentPage == index ? AppColor.primary : AppColor.grey,
                  BlendMode.srcIn),
              width: 18,
              height: 18,
            ),
            currentPage == index
                ? Column(
                    children: [
                      const SizedBox(height: 5),
                      Text(icon.name,
                          style: TextStyle(
                            color: currentPage == index
                                ? AppColor.primary
                                : AppColor.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
