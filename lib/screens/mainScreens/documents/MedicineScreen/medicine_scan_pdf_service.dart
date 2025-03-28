import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart';

import '../../../../consts/themes.dart';


class MedicineScanPDFService {
  static Future<File> _generatePDF(List<String> medicines, String fileName) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Medicines Report',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Generated on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
              style: pw.TextStyle(fontSize: 12),
            ),
            pw.Divider(),
            pw.Text(
              'Detected Medicines (${medicines.length}):',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            ...medicines.map((medicine) => pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Text('• $medicine', style: pw.TextStyle(fontSize: 14)),
            )),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$fileName.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static Future<void> sharePDF(BuildContext context, List<String> medicines) async {
    try {
      final defaultName = 'medicines_${DateFormat('yyyyMMdd').format(DateTime.now())}';
      final file = await _generatePDF(medicines, defaultName);
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Here is my medicines list',
        subject: 'Medicines Report',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share PDF: ${e.toString()}'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  static Future<void> savePDF(BuildContext context, List<String> medicines) async {
    final controller = TextEditingController(
        text: 'medicines_${DateFormat('yyyyMMdd').format(DateTime.now())}'
    );

    final fileName = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(
          'Save PDF As',
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
            labelText: 'File Name',
            hintText: 'Enter PDF file name',
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
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(context, controller.text.trim());
              }
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

    if (fileName != null && fileName.isNotEmpty) {
      try {
        final file = await _generatePDF(medicines, fileName);
        final directory = await getApplicationDocumentsDirectory();
        final savedFile = File('${directory.path}/$fileName.pdf');
        await savedFile.writeAsBytes(await file.readAsBytes());

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'PDF saved successfully',
                style: TextStyle(
                  fontFamily: 'Oregano',
                  color: AppColors.white,
                  fontSize: 16.0,
                ),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: AppColors.navy,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              action: SnackBarAction(
                label: 'Open',
                textColor: AppColors.gold,
                onPressed: () => OpenFile.open(savedFile.path),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            )
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving PDF: ${e.toString()}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}