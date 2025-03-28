import 'package:flutter/material.dart';
import 'package:medi_vision_app/consts/themes.dart';

class DashboardSearchBar extends StatelessWidget {
  const DashboardSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class ScannedToday extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback toggleExpansion;

  const ScannedToday({
    Key? key,
    required this.isExpanded,
    required this.toggleExpansion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('13 images uploaded',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark)),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.blue,
                  ),
                  onPressed: toggleExpansion,
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                      width: 150,
                      height: 150,
                      color: AppColors.navy),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                          width: 150,
                          height: 65,
                          color: AppColors.navy),
                      const SizedBox(height: 5),
                      Container(
                        width: 150,
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
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
            ] else ...[
              const SizedBox(height: 8),
              Container(
                width: 150,
                height: 150,
                color: AppColors.navy,
                alignment: Alignment.center,
                child: Text('Recent Image',
                    style: TextStyle(
                        color: Colors.white)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final String route;
  final Map<String, dynamic> userData;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.route,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route, arguments: userData),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
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
                  Text(title, style: TextStyle(fontSize: 14, color: AppColors.textDark)),
                  Text('$count File${count > 1 ? 's' : ''}',
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}