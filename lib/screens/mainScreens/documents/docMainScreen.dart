import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts/themes.dart';

class DocumentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navy),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.navy, size: 35),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Document',
                style: GoogleFonts.inter(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 30),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search files...',
                hintStyle: TextStyle(fontSize: 13),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFFF3F8F7), // Lighter background color
                border: OutlineInputBorder( // Rounded border
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 16), // Adjust font size for better readability
              textAlignVertical: TextAlignVertical.center, // Centers the text vertically
            ),
            SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align children to the start
              children: [
                Text('Sort by date', style: TextStyle(color: AppColors.navy, fontSize: 12)),
                SizedBox(width: 8), // Adds space between the text and the icon
                Icon(Icons.expand_more_outlined),
              ],
            ),
            SizedBox(height: 20),
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            SizedBox(height: 10),
            _buildDocumentItem('my-prescription.pdf', 11, true),
            _buildDocumentItem('receipt.pdf', 6, false),
            _buildDocumentItem('doc.pdf', 3, false),
            SizedBox(height: 20),
            const Text(
              'Last Week',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
            SizedBox(height: 10),
            _buildDocumentItem('XYZ.pdf', 1, false),
            _buildDocumentItem('ABC.pdf', 2, false),
          ],
        ),

      ),
    );
  }

  Widget _buildDocumentItem(String title, int pages, bool isStarred) {
    return ListTile(
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.accent, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            '.pdf',
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(title,style: TextStyle(fontSize: 16,color: AppColors.navy),),
      subtitle: Text('$pages Pages',style: TextStyle(fontSize: 11),),
      trailing: isStarred
          ? Icon(Icons.star, color: AppColors.accent)
          : Icon(Icons.more_vert, color: Colors.grey),
    );
  }
}
