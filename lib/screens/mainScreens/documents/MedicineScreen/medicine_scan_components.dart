import 'package:flutter/material.dart';
import '../../../../consts/themes.dart';


Widget buildScanPreview() {
  return Container(
    height: 180,
    decoration: BoxDecoration(
      color: AppColors.primary.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        Center(
          child: Icon(Icons.document_scanner, size: 50, color: AppColors.primary),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'SCAN RESULT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMedicinesListHeader(int count) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Detected Medicines',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.navy,
        ),
      ),
      Text(
        '$count items',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    ],
  );
}

List<Widget> buildMedicinesList(
    List<String> medicines,
    Function(String) onEdit,
    Function(String) onDelete,
    ) {
  return medicines.map((medicine) => Container(
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.medication_liquid, size: 20, color: AppColors.primary),
      ),
      title: Text(
        medicine,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.navy,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, size: 20, color: AppColors.primary),
            onPressed: () => onEdit(medicine),
          ),
          IconButton(
            icon: Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: () => onDelete(medicine),
          ),
        ],
      ),
    ),
  )).toList();
}

Widget buildActionButtons(
    BuildContext context, {
      required VoidCallback onAddNew,
      required VoidCallback onSavePDF,
    }) {
  return Column(
    children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(Icons.search, size: 22, color: Colors.white),
          label: Text(
            'Search Uses',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
        ),
      ),
      SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.add, size: 20, color: AppColors.primary),
              label: Text('Add New'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: AppColors.primary),
              ),
              onPressed: onAddNew,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.download, size: 20, color: AppColors.primary),
              label: Text('Save PDF'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: AppColors.primary),
              ),
              onPressed: onSavePDF,
            ),
          ),
        ],
      ),
    ],
  );
}