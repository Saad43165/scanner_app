import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/themes.dart';

class AnimatedNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _AnimatedNavBarState createState() => _AnimatedNavBarState();
}

class _AnimatedNavBarState extends State<AnimatedNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 40.0, // Reduced height to prevent overflow
        padding: const EdgeInsets.symmetric(horizontal: 10.0), // Added horizontal padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0, "Home"),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(Icons.qr_code_scanner, 1, "Scan"),
            const SizedBox(width: 48), // Space for FAB
            _buildNavItem(Icons.person, 2, "Profile"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    bool isSelected = widget.currentIndex == index;
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: SizedBox( // Use SizedBox to constrain size
        width: 60, // Fixed width for each item
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 32, // Reduced height
              width: 32,  // Reduced width
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.navy,
                size: isSelected ? 28.0 : 24.0, // Adjusted sizes
              ),
            ),
            const SizedBox(height: 4),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isSelected ? 1.0 : 0.0,
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 10.0, // Smaller font size
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Scan Page")),
    const Center(child: Text("Profile Page")),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: AnimatedNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.nightlight_round, color: Colors.black),
        backgroundColor: Colors.orange,
        elevation: 2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}