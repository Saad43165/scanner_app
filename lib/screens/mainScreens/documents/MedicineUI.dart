import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../consts/themes.dart';

class MedicineScanPage extends StatelessWidget {
  final List<String> medicines = ["Medicine 1", "Medicine 2", "Medicine 3", "Medicine 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navy),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_calendar_rounded, color: AppColors.textDark),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.print, color: AppColors.textDark),
            onPressed: () {},
          ),
        ],
        title: const Text(
          'Scan 01:11:2020 03...',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/medicine_scan_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4 Medicines Found!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Column(
                children: medicines.map((medicine) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        medicine,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Search for Uses',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: AppColors.textDark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: AppColors.textDark),
                    onPressed: () => _sharePDF(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: AppColors.textDark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: AppColors.textDark),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function to generate a PDF file
  Future<File> _generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Medicines Found:", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              for (String medicine in medicines) pw.Text(medicine, style: pw.TextStyle(fontSize: 16)),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/medicines.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Function to generate and share the PDF
  Future<void> _sharePDF(BuildContext context) async {
    try {
      final file = await _generatePDF();
      Share.shareXFiles([XFile(file.path)], text: "Medicines List PDF");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating PDF: $e")),
      );
    }
  }
}