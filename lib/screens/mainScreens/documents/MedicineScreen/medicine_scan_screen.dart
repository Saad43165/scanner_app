import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../consts/themes.dart';
import 'medicine_scan_components.dart';
import 'medicine_scan_helpers.dart';
import 'medicine_scan_pdf_service.dart';

class MedicineScanPage extends StatefulWidget {
  const MedicineScanPage({Key? key}) : super(key: key);

  @override
  State<MedicineScanPage> createState() => _MedicineScanPageState();
}

class _MedicineScanPageState extends State<MedicineScanPage> {
  List<String> medicines = ["Medicine 1", "Medicine 2", "Medicine 3", "Medicine 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navy),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Scan Result - ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: AppColors.primary),
            onPressed: () => _sharePDF(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildScanPreview(),
              SizedBox(height: 24),
              buildMedicinesListHeader(medicines.length),
              SizedBox(height: 16),
              ...buildMedicinesList(
                medicines,
                    (medicine) => _editMedicine(medicine),
                    (medicine) => _deleteMedicine(medicine),
              ),
              SizedBox(height: 24),
              buildActionButtons(
                context,
                onAddNew: _addNewMedicine,
                onSavePDF: () => _savePDF(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sharePDF(BuildContext context) async {
    await MedicineScanPDFService.sharePDF(context, medicines);
  }

  Future<void> _savePDF(BuildContext context) async {
    await MedicineScanPDFService.savePDF(context, medicines);
  }

  void _addNewMedicine() {
    MedicineScanHelpers.addNewMedicine(context, (newMedicine) {
      setState(() => medicines.add(newMedicine));
    });
  }

  void _editMedicine(String medicine) {
    MedicineScanHelpers.editMedicine(context, medicine, (updatedMedicine) {
      setState(() {
        final index = medicines.indexOf(medicine);
        if (index != -1) medicines[index] = updatedMedicine;
      });
    });
  }

  void _deleteMedicine(String medicine) {
    MedicineScanHelpers.deleteMedicine(context, medicine, () {
      setState(() => medicines.remove(medicine));
    });
  }
}