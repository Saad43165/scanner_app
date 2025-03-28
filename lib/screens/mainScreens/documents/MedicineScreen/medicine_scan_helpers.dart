import 'package:flutter/material.dart';
import '../../../../consts/themes.dart' show AppColors;


class MedicineScanHelpers {
  static void addNewMedicine(
      BuildContext context,
      Function(String) onAdd,
      ) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Add New Medicine',
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 16.0,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            labelText: 'Medicine Name',
            labelStyle: TextStyle(
              fontFamily: 'Oregano',
              color: AppColors.grey,
            ),
            filled: true,
            fillColor: AppColors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              onAdd(controller.text.trim());
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
                color: AppColors.white,
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.end,
        actionsPadding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
      )
    );
  }

  static void editMedicine(
      BuildContext context,
      String medicine,
      Function(String) onEdit,
      ) {
    final controller = TextEditingController(text: medicine);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Edit Medicine',
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 16.0,
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            labelText: 'Medicine Name',
            labelStyle: TextStyle(
              fontFamily: 'Oregano',
              color: AppColors.grey,
            ),
            filled: true,
            fillColor: AppColors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              if (controller.text.trim().isEmpty) return;
              onEdit(controller.text.trim());
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void deleteMedicine(
      BuildContext context,
      String medicine,
      Function() onDelete,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Delete Medicine',
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "$medicine"?',
          style: TextStyle(
            fontFamily: 'Oregano',
            fontSize: 16.0,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
                color: AppColors.primary,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              onDelete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text(
                    '"$medicine" deleted successfully',
                    style: TextStyle(fontFamily: 'Oregano'),
                  ),
                  backgroundColor: AppColors.navy,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Oregano',
                fontSize: 16.0,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}