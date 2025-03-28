import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/bottomNavbar.dart';
import '../../../consts/themes.dart';
import 'profile_components.dart';
import 'profile_helpers.dart';

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
      'phoneNumber': phoneNumber.replaceAll('PK +92 ', '').replaceAll(RegExp(r'[^0-9]'), ''),
      'userType': userType,
    };

    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: AnimatedNavBar(
        onTap: _onNavBarTapped,
        currentIndex: _selectedIndex,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        actions: [
          buildProfilePopupMenu(
            context,
            onEdit: (ctx, args) => ProfileHelpers.editProfile(ctx, args),
            onLogout: _logout,
            editArgs: editArgs,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            buildProfileAvatar(context),
            buildUserName(fullName, context),
            buildUserTypeBadge(userType, context),
            const SizedBox(height: 32),
            buildProfileInfoCard(email, phoneNumber, context),
          ],
        ),
      ),
    );
  }

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
}