import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/themes.dart';
import 'package:provider/provider.dart';
import '../../menu/notification_provider.dart';
import 'dashboard_components.dart';

Widget buildMenuButton(BuildContext context, NotificationProvider notificationProvider) {
  return PopupMenuButton(
    icon: Icon(Icons.menu_outlined,
        color: AppColors.textDark,
        size: 30),
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: ListTile(
          leading: Icon(Icons.notifications_active,
              color: AppColors.primary),
          title: Text(notificationProvider.notificationsEnabled
              ? 'Disable Notifications'
              : 'Enable Notifications',
              style: TextStyle(
                  color: AppColors.textDark
              )),
          onTap: () {
            notificationProvider.toggleNotifications(!notificationProvider.notificationsEnabled);
            Navigator.pop(context);
          },
        ),
      ),
    ],
  );
}

Widget buildSectionTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
    ),
  );
}

Widget buildCategoryGrid(BuildContext context, Map<String, dynamic> userData) {
  return GridView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.8,
    ),
    children: [
      CategoryCard(
        title: 'Personal',
        count: 120,
        icon: Icons.person,
        color: Colors.purple,
        route: '/personal',
        userData: userData,
      ),
      CategoryCard(
        title: 'Document',
        count: 58,
        icon: Icons.insert_drive_file,
        color: Colors.red,
        route: '/document',
        userData: userData,
      ),
      CategoryCard(
        title: 'Files',
        count: 41,
        icon: Icons.folder,
        color: Colors.green,
        route: '/files',
        userData: userData,
      ),
      CategoryCard(
        title: 'Gallery',
        count: 46,
        icon: Icons.image,
        color: Colors.blue,
        route: '/gallery',
        userData: userData,
      ),
    ],
  );
}