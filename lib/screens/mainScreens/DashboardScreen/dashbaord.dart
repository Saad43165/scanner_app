import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../consts/bottomNavbar.dart';
import '../../../consts/themes.dart';
import '../../menu/notification_provider.dart';
import 'dashboard_components.dart';
import 'dashboard_helpers.dart';
import '';

class Dashboard extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const Dashboard({Key? key, this.userData}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late Map<String, dynamic> _userData;
  bool _isExpanded = true;

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
    if (_selectedIndex == index) return;

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
      arguments: _userData,
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: buildMenuButton(context, notificationProvider),
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
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 20),
              const DashboardSearchBar(),
              const SizedBox(height: 30),
              buildSectionTitle('Recently'),
              const SizedBox(height: 10),
              buildCategoryGrid(context, _userData),
              const SizedBox(height: 30),
              buildSectionTitle('Scanned Today'),
              Text('January, 11', style: TextStyle(
                  color: Colors.grey.shade500
              )),
              const SizedBox(height: 10),
              ScannedToday(
                isExpanded: _isExpanded,
                toggleExpansion: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
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
}