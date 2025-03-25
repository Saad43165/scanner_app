import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/bottomNavbar.dart';
import '../../consts/themes.dart';

class Dashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const Dashboard({Key? key, this.userData}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _userData = widget.userData ?? {
      'fullName': '',
      'email': '',
      'phoneNumber': '',
      'userType': 'Normal User'
    };
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
              (route) => false,
          arguments: _userData,
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(
          context,
          '/scandocscreen',
          arguments: _userData,
        );
        break;
      case 2:
        Navigator.pushReplacementNamed(
          context,
          '/profile',
          arguments: _userData,
        );
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu_outlined, color: Colors.black, size: 35),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedNavBar(
        onTap: _onNavBarTapped,
        currentIndex: _selectedIndex,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Dashboard Files',
                  style: GoogleFonts.inter(
                    color: AppColors.navy,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 20),
                _buildSearchBar(),
                SizedBox(height: 20),
                _buildSectionTitle('Recently'),
                _buildCategoryGrid(),
                SizedBox(height: 20),
                _buildSectionTitle('Scanned today'),
                Text('January, 11',
                    style: TextStyle(color: Colors.grey.shade400)),
                SizedBox(height: 10),
                _buildScannedToday(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Search files...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Color(0xFFF3F8F7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.navy,
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      children: [
        _buildCategoryCard(
            'Personal', 120, Icons.person, Colors.purple, '/personal'),
        _buildCategoryCard(
            'Document', 58, Icons.insert_drive_file, Colors.red, '/document'),
        _buildCategoryCard('Files', 41, Icons.folder, Colors.green, '/files'),
        _buildCategoryCard('Gallery', 46, Icons.image, Colors.blue, '/gallery'),
      ],
    );
  }

  Widget _buildCategoryCard(
      String title, int count, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 14, color: AppColors.navy),
                  ),
                  Text(
                    '$count File${count > 1 ? 's' : ''}',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScannedToday() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('13 images uploaded',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.navy)),
              Icon(Icons.expand_more, color: Colors.blue),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(width: 150, height: 150, color: AppColors.navy),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(width: 150, height: 65, color: AppColors.navy),
                  SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('+11 photos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
