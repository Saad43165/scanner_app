import 'package:flutter/material.dart';

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
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 0, "Home"),
            _buildNavItem(Icons.qr_code_scanner, 1, "Scan"),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: isSelected ? 40 : 20,
            width: isSelected ? 40 : 20,
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white,
              size: 24.0,
            ),
          ),
          if (isSelected)
            Text(
              label,
              style: TextStyle(color: Colors.orange, fontSize: 12.0),
            ),
        ],
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
    Center(child: Text("Home Page")),
    Center(child: Text("Scan Page")),
    Center(child: Text("Profile Page")),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


