import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/shared/projects_card.dart';

class ProjectScreenUI extends StatelessWidget {
  const ProjectScreenUI({super.key, required this.isDarkMode, required this.toggleTheme});

  final bool isDarkMode;
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;

    final project = ProjectSection(
      isDarkMode: isDarkMode,

      projects: [
        Project(
          name: 'Bexca',
          description:
              '''I developed the official mobile application for Barishal Cadet College's Ex-Cadets' Association (BEXCA) using Flutter with Flutter Bloc for state management. The app features membership management, event registration, and payment processing capabilities, allowing users to access member information and stay updated with association activities. I implemented Hive for local storage to ensure seamless offline functionality.''',
          techStack: ['Flutter', 'Dart', 'Flutter Bloc', 'Hive'],
          googleUrl: 'https://play.google.com/store/apps/details?id=org.bexca.bexca_mobile_app&pcampaignid=web_share',
          appleUrl: 'https://apps.apple.com/at/app/bexca/id6465697710?l=en-GB',
          liveUrl: '',
          imagePath: 'assets/images/bexca.png',
        ),
        Project(
          name: 'Flutter Web Portfolio',
          description:
              '''Personal portfolio website showcasing my professional experience and technical skills. Built with Flutter Web featuring responsive design and dark/light mode toggle. Implemented interactive skill badges and timeline-based experience display. Optimized for cross-device compatibility with clean architecture principles.''',
          techStack: ['Flutter', 'Dart', 'Flutter Web'],
          googleUrl: '',
          appleUrl: '',
          liveUrl: 'https://your-portfolio-website.com',
          imagePath: 'assets/images/portfolio.png',
        ),
        // Add more projects here
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [project], // Note: You're returning the entire ProjectSection, not a ProjectsCard
    );
  }
}
