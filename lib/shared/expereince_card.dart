import 'package:flutter/material.dart';
import '../../config/constant/colors.dart';

class ExperienceCard extends StatefulWidget {
  final String name;
  final String title;
  final String address;
  final String duration;
  final String worktime;
  final String description;
  final String imagePath;
  final bool isDarkMode;

  const ExperienceCard({
    super.key,
    required this.name,
    required this.title,
    required this.address,
    required this.duration,
    required this.worktime,
    required this.description,
    required this.imagePath,
    required this.isDarkMode,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
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
                        Row(
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.isDarkMode ? AppColors.white : AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              _isExpanded ? Icons.expand_less : Icons.expand_more,
                              color: widget.isDarkMode ? AppColors.white : AppColors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.title,
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
                    children: [
                      Text(widget.duration, style: TextStyle(color: AppColors.grey, fontSize: 13)),
                      const SizedBox(height: 5),
                      Text(widget.worktime, style: TextStyle(color: AppColors.grey, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstCurve: Curves.easeIn,
              secondCurve: Curves.easeOut,
              firstChild: Container(),
              secondChild: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: widget.isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: widget.isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
