import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/bottomNavbar.dart';
import '../../../consts/themes.dart';

class ProfileScreen extends StatefulWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String userType;

  const ProfileScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.userType,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2;

  void _onNavBarTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/scandocscreen');
        break;
      case 2:
        break;
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Logout',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: AppColors.navy,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/authOption');
              },
              child: Text(
                'Logout',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _editProfile(BuildContext context, Map<String, dynamic> args) {
    Navigator.pushNamed(
      context,
      '/register',
      arguments: args,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final fullName = routeArgs?['fullName'] ?? widget.fullName;
    final email = routeArgs?['email'] ?? widget.email;
    final phoneNumber = routeArgs?['phoneNumber'] ?? widget.phoneNumber;
    final userType = routeArgs?['userType'] ?? widget.userType;

    final editArgs = {
      'editMode': true,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber.replaceAll('PK +92 ', ''),
      'userType': userType,
    };

    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: AnimatedNavBar(
        onTap: _onNavBarTapped,
        currentIndex: _selectedIndex,
      ),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppColors.navy,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.navy),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.navy),
            onSelected: (value) {
              if (value == 'edit') {
                _editProfile(context, editArgs);
              } else if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('Edit Profile'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Profile Avatar
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: Responsive.width(context) * 0.15, // Reduced size
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: Responsive.width(context) * 0.15, // Reduced size
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6), // Reduced padding
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16, // Reduced size
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),

            // User Name
            Text(
              fullName.isNotEmpty ? fullName : 'No Name Provided',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.navy,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // User Type Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
            ),
            SizedBox(height: 32),

            // Profile Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    _buildProfileInfo('Email', email, Icons.email_outlined),
                    Divider(height: 1, indent: 16, endIndent: 16),
                    _buildProfileInfo('Phone', phoneNumber, Icons.phone_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon) {
    final displayValue = value.isEmpty ? 'Not provided' : value;
    final textColor = value.isEmpty ? Colors.grey[600] : AppColors.navy;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          SizedBox(width: 16),
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
                SizedBox(height: 4),
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
}