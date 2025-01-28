import 'package:flutter/material.dart';
import '../../../consts/themes.dart';

class MedicineScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navy),
          onPressed: () {},
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
          'Scan 01:11:2020 03...', // Text content
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontWeight: FontWeight.bold, // Makes the text bold
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
                height: Responsive.height(context) * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/medicine_scan_image.png'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(context) * 0.02),
              Text(
                '4 Medicines Found!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: Responsive.height(context) * 0.02),
              Column(
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      height: Responsive.height(context) * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Medicine ${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: Responsive.height(context) * 0.03),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width(context) * 0.1,
                      vertical: Responsive.height(context) * 0.02,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Search for Uses',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              SizedBox(height: Responsive.height(context) * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline, color: AppColors.textDark),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: AppColors.textDark),
                    onPressed: () {},
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
}
