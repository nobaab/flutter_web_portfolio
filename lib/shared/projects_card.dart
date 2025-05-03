import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/constant/colors.dart';

/// Model representing a project including tech stack and various URLs
class Project {
  final String name;
  final List<String> techStack;
  final String googleUrl;
  final String appleUrl;
  final String liveUrl;
  final String description;
  final String imagePath;

  const Project({
    required this.name,
    required this.techStack,
    this.googleUrl = '',
    this.appleUrl = '',
    this.liveUrl = '',
    required this.description,
    required this.imagePath,
  });
}

/// A card widget for each project, with expand/collapse, tech list, and live links
class ProjectsCard extends StatefulWidget {
  final Project project;
  final bool isDarkMode;
  final bool isMobile;

  const ProjectsCard({super.key, required this.project, required this.isDarkMode, required this.isMobile});

  @override
  State<ProjectsCard> createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: widget.isDarkMode ? AppColors.blueDark : AppColors.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Column(
          children: [
            // Header: avatar, name, expand icon
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: AssetImage(widget.project.imagePath),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.project.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: widget.isDarkMode ? AppColors.white : AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              _expanded ? Icons.expand_less : Icons.expand_more,
                              color: widget.isDarkMode ? AppColors.white : AppColors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Tech stack list
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                widget.project.techStack.map((tech) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      tech,
                                      style: TextStyle(
                                        color: widget.isDarkMode ? AppColors.white : AppColors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Store links
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (widget.project.googleUrl.isNotEmpty && widget.isMobile == false)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _launchUrl(widget.project.liveUrl),
                        icon: const Icon(Icons.android),
                        label: Text(
                          'Google Play',
                          style: TextStyle(color: widget.isDarkMode ? AppColors.white : AppColors.black),
                        ),
                      ),
                    ),
                  if (widget.project.appleUrl.isNotEmpty && widget.isMobile == false)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => _launchUrl(widget.project.liveUrl),
                        icon: const Icon(Icons.apple),
                        label: Text(
                          'App Store',
                          style: TextStyle(color: widget.isDarkMode ? AppColors.white : AppColors.black),
                        ),
                      ),
                    ),

                  if (widget.project.googleUrl.isNotEmpty && widget.isMobile == true)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () => _launchUrl(widget.project.liveUrl),
                        icon: const Icon(Icons.android),
                      ),
                    ),
                  if (widget.project.appleUrl.isNotEmpty && widget.isMobile == true)
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(onPressed: () => _launchUrl(widget.project.liveUrl), icon: const Icon(Icons.apple)),
                    ),
                ],
              ),
            ),
            // Expanded description
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
                      widget.project.description,
                      style: TextStyle(
                        color: widget.isDarkMode ? AppColors.white : AppColors.black,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}

/// Section to display all projects in a responsive grid
class ProjectSection extends StatelessWidget {
  final bool isDarkMode;
  final List<Project> projects;

  const ProjectSection({Key? key, required this.isDarkMode, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final crossAxisCount =
        isMobile
            ? 1
            : screenWidth < 1200
            ? 2
            : 3;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Projects', style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.builder(
            itemCount: projects.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder:
                (context, index) => ProjectsCard(project: projects[index], isDarkMode: isDarkMode, isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}
