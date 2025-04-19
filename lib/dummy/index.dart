import '../constants/app_image.dart';
import '../models/bottom_navigation_model.dart';

List<BottomNavigationModel> bottomNavigationData = [
  BottomNavigationModel(id: 1, name: "Home", icon: AppImage.imagesIconesHome),
  BottomNavigationModel(
      id: 2,
      name: "Employees",
      icon: AppImage.imagesIconesUsersGroupTwoRounded),
  BottomNavigationModel(
      id: 3, name: "Leaves", icon: AppImage.imagesIconesClipboard),
  BottomNavigationModel(
      id: 4, name: "Settings", icon: AppImage.imagesIconesSettings),
];
