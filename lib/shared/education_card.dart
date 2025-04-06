import 'package:flutter/material.dart';
import '../../config/constant/colors.dart';

class EducationCard extends StatefulWidget {
  final String name;
  final String degree;
  final String address;
  final String duration;
  final bool isDarkMode;
  final String imagePath;

  const EducationCard({
    super.key,
    required this.name,
    required this.degree,
    required this.address,
    required this.duration,
    required this.isDarkMode,
    required this.imagePath,
  });

  @override
  State<EducationCard> createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.isDarkMode ? AppColors.blueDark : AppColors.cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: AssetImage(widget.imagePath),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.isDarkMode ? AppColors.white : AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.degree,
                          style: TextStyle(
                            color: widget.isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.address,
                          style: TextStyle(
                            color: widget.isDarkMode ? AppColors.white : AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Text(widget.duration, style: TextStyle(color: AppColors.grey, fontSize: 13))],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
