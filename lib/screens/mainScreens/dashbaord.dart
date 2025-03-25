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
    if (_selectedIndex == index) return; // Prevent unnecessary reloads

    setState(() {
      _selectedIndex = index;
    });

    final String routeName;
    switch (index) {
      case 0:
        routeName = '/dashboard';
        break;
      case 1:
        routeName = '/scandocscreen';
        break;
      case 2:
        routeName = '/profile';
        break;
      default:
        return;
    }

    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: _userData,  // Make sure to pass the userData EVERY TIME
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu_outlined, color: Colors.black, size: 30),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Dashboard Files',
                style: GoogleFonts.inter(
                  color: AppColors.navy,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 30),
              _buildSectionTitle('Recently'),
              const SizedBox(height: 10),
              _buildCategoryGrid(),
              const SizedBox(height: 30),
              _buildSectionTitle('Scanned Today'),
              Text('January, 11', style: TextStyle(color: Colors.grey.shade500)),
              const SizedBox(height: 10),
              _buildScannedToday(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: AnimatedNavBar(
          currentIndex: _selectedIndex,
          onTap: _onNavBarTapped,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Search files...',
        prefixIcon: Icon(Icons.search, color: Colors.grey),
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
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      children: [
        _buildCategoryCard('Personal', 120, Icons.person, Colors.purple, '/personal'),
        _buildCategoryCard('Document', 58, Icons.insert_drive_file, Colors.red, '/document'),
        _buildCategoryCard('Files', 41, Icons.folder, Colors.green, '/files'),
        _buildCategoryCard('Gallery', 46, Icons.image, Colors.blue, '/gallery'),
      ],
    );
  }

  Widget _buildCategoryCard(String title, int count, IconData icon, Color color, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route, arguments: _userData),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, color: AppColors.navy)),
                  Text(
                    '$count File${count > 1 ? 's' : ''}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('13 images uploaded', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navy)),
              Icon(Icons.expand_more, color: Colors.blue),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(width: 150, height: 150, color: AppColors.navy),
              const SizedBox(width: 10),
              Column(
                children: [
                  Container(width: 150, height: 65, color: AppColors.navy),
                  const SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text('+11 photos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
