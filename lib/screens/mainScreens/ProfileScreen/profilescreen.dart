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
    Navigator.pushReplacementNamed(context, '/authOption');
  }

  @override
  Widget build(BuildContext context) {
    // Get any additional arguments passed directly
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Use passed arguments if available, otherwise use widget properties
    final fullName = routeArgs?['fullName'] ?? widget.fullName;
    final email = routeArgs?['email'] ?? widget.email;
    final phoneNumber = routeArgs?['phoneNumber'] ?? widget.phoneNumber;
    final userType = routeArgs?['userType'] ?? widget.userType;

    return Scaffold(
      backgroundColor: AppColors.navy, // Using theme color
      bottomNavigationBar: AnimatedNavBar(
        onTap: _onNavBarTapped,
        currentIndex: _selectedIndex,
      ),
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.navy,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: AppColors.white),
            onPressed: () => Navigator.pushNamed(
              context,
              '/register',
              arguments: {
                'editMode': true,
                'fullName': fullName,
                'email': email,
                'phoneNumber': phoneNumber.replaceAll('PK +92 ', ''),
                'userType': userType,
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: AppColors.navy,
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildProfileInfo('Full Name', fullName),
                          Divider(color: Colors.grey[300]),
                          _buildProfileInfo('Email', email),
                          Divider(color: Colors.grey[300]),
                          _buildProfileInfo('Phone Number', phoneNumber),
                          Divider(color: Colors.grey[300]),
                          _buildProfileInfo('User Type', userType),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: Text(
                  'LOG OUT',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    final displayValue = value.isEmpty ? 'Not provided' : value;
    final textColor = value.isEmpty ? Colors.grey : AppColors.navy;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.navy.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForLabel(label),
              color: AppColors.navy,
              size: 22,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
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

  IconData _getIconForLabel(String label) {
    switch (label) {
      case 'Full Name':
        return Icons.person_outline;
      case 'Email':
        return Icons.email_outlined;
      case 'Phone Number':
        return Icons.phone_outlined;
      case 'User Type':
        return Icons.verified_user_outlined;
      default:
        return Icons.info_outline;
    }
  }
}