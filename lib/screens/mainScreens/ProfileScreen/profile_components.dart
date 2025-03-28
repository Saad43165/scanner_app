import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/themes.dart';
import 'profile_helpers.dart';

// Profile Avatar Component
Widget buildProfileAvatar(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(top: 30, bottom: 20),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: Responsive.width(context) * 0.15,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(
            Icons.person,
            size: Responsive.width(context) * 0.15,
            color: AppColors.primary,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.camera_alt,
            size: 16,
            color: AppColors.white,
          ),
        ),
      ],
    ),
  );
}

// User Name Component
Widget buildUserName(String fullName, BuildContext context) {
  return Text(
    fullName.isNotEmpty ? fullName : 'No Name Provided',
    style: Theme.of(context).textTheme.displayLarge?.copyWith(
      color: AppColors.navy,
    ),
    textAlign: TextAlign.center,
  );
}

// User Type Badge Component
Widget buildUserTypeBadge(String userType, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppColors.primary, width: 1),
    ),
    child: Text(
      userType.toUpperCase(),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
  );
}

// Profile Info Card Component
Widget buildProfileInfoCard(String email, String phoneNumber, BuildContext context) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          _buildProfileInfoItem('Email', email, Icons.email_outlined, context),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _buildProfileInfoItem('Phone', phoneNumber, Icons.phone_outlined, context),
        ],
      ),
    ),
  );
}

// Profile Popup Menu Component
Widget buildProfilePopupMenu(BuildContext context, {
  required Function(BuildContext, Map<String, dynamic>) onEdit,
  required Function() onLogout,
  required Map<String, dynamic> editArgs,
}) {
  return PopupMenuButton<String>(
    icon: Icon(Icons.more_vert,
      color: AppColors.navy,
      size: 28,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 1),
    ),
    elevation: 4,
    color: AppColors.white,
    onSelected: (value) {
      if (value == 'edit') {
        onEdit(context, editArgs);
      } else if (value == 'logout') {
        ProfileHelpers.showLogoutDialog(context, onLogout);
      }
    },
    itemBuilder: (BuildContext context) {
      return [
        ProfileHelpers.buildMenuItem(
          context,
          icon: Icons.edit,
          label: 'Edit Profile',
          value: 'edit',
        ),
        ProfileHelpers.buildMenuItem(
          context,
          icon: Icons.logout,
          label: 'Logout',
          value: 'logout',
          isDestructive: true,
        ),
      ];
    },
  );
}

// Private helper for profile info items
Widget _buildProfileInfoItem(String label, String value, IconData icon, BuildContext context) {
  final displayValue = value.isEmpty ? 'Not provided' : value;
  final textColor = value.isEmpty ? Colors.grey[600] : AppColors.navy;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayValue,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}