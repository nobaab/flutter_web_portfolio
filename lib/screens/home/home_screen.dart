import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/shared/expereince_card.dart';
import 'package:flutter_web_portfolio/shared/skill_chip.dart';
import '../../shared/animated_button.dart';
import '../../shared/footer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenUI extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const HomeScreenUI({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  late ScrollController _scrollController;
  double navbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController()..addListener(() {
          double newOpacity = _scrollController.offset > 50 ? 0.9 : 1.0;
          setState(() {
            navbarOpacity = newOpacity;
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main content
        Text(
          'Bringing Your Ideas to Life Through Software',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 16, color: widget.isDarkMode ? Colors.white : Colors.black),
            children: [
              const TextSpan(text: "Hello! I specialize in combining "),
              TextSpan(
                text: "engineering expertise",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, decoration: TextDecoration.underline),
              ),
              const TextSpan(
                text: " with a deep understanding of business needs to deliver impactful software solutions.\n\n",
              ),

              const TextSpan(text: "With experience in "),
              TextSpan(text: "Flutter", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w600)),
              const TextSpan(text: " and "),
              TextSpan(text: "Golang", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
              const TextSpan(text: ", I build scalable, high-performance applications that meet modern challenges.\n\n"),

              const TextSpan(text: "My goal is to create solutions that are both "),
              TextSpan(
                text: "innovative",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
              ),
              const TextSpan(text: " and aligned with "),
              TextSpan(
                text: "business objectives.",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
              ),
              const TextSpan(text: "\n\n"),

              TextSpan(
                text: "Let's work together",
                style: TextStyle(backgroundColor: Colors.orangeAccent, fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: " to build something "),
              TextSpan(
                text: "remarkable.",
                style: TextStyle(backgroundColor: Colors.yellowAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Buttons Section
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlowButton(
            text: "Download CV!",
            icon: Icons.description,
            glowColor: Colors.cyan,
            textColor: Colors.cyan.shade700,
            onPressed: () {
              final Uri url = Uri.parse("https://mozammel.me/mozammel_cv.pdf");
              launchUrl(
                url,
                webOnlyWindowName: '_blank', // Open in new browser tab
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // Skills Section
        Text(
          'Technical Skills',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 14,
          children: [
            SkillChip(label: 'Dart', icon: Icons.code, accentColor: Colors.blue, isDarkMode: widget.isDarkMode),
            SkillChip(
              label: 'Golang',
              icon: Icons.integration_instructions,
              accentColor: Colors.teal,
              isDarkMode: widget.isDarkMode,
            ),
            SkillChip(
              label: 'Flutter',
              icon: Icons.flutter_dash,
              accentColor: Colors.lightBlue,
              isDarkMode: widget.isDarkMode,
            ),
            SkillChip(label: 'Go Gin', icon: Icons.web, accentColor: Colors.green, isDarkMode: widget.isDarkMode),
            SkillChip(label: 'Firebase', icon: Icons.storage, accentColor: Colors.amber, isDarkMode: widget.isDarkMode),
            SkillChip(
              label: 'PostgreSQL',
              icon: Icons.storage_rounded,
              accentColor: Colors.indigo,
              isDarkMode: widget.isDarkMode,
            ),
            SkillChip(label: 'GitHub', icon: Icons.code_rounded, accentColor: Colors.purple, isDarkMode: widget.isDarkMode),
            SkillChip(
              label: 'Linux',
              icon: Icons.terminal,
              accentColor: Colors.grey.shade700,
              isDarkMode: widget.isDarkMode,
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Experience Section
        Text(
          'Experience',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        ExperienceCard(
          name: 'B-Block Digital',
          title: 'Software Engineer',
          address: 'France – Remote',
          duration: 'Feb 2023 – Present',
          worktime: 'Full-time',
          description:
              'Engineered a robust iPad POS system using Flutter and Bloc for state management. Developed and maintained a Sales App with a Golang backend, improving sales tracking efficiency. Reduced backend API response times by 40% through Golang optimization. Built scalable RESTful APIs and collaborated with a remote team to deliver cross-functional projects.',
          imagePath: 'assets/images/bblock.png',
          isDarkMode: widget.isDarkMode,
        ),
        const SizedBox(height: 10),
        ExperienceCard(
          name: 'Bizzntek Ltd',
          title: 'Associate Software Engineer',
          address: 'Uttara, Dhaka, Bangladesh',
          duration: 'Sep 2022 – May 2023',
          worktime: 'Full-time',
          description:
              'Promoted from Intern to Associate Software Engineer. Developed Flutter-based mobile applications with strong expertise in Flutter Bloc for state management. Integrated RESTful APIs to enhance app features and collaborated within a dynamic team to meet project milestones.',
          imagePath: 'assets/images/bizzntek_logo.jpeg',
          isDarkMode: widget.isDarkMode,
        ),
        // Footer
        const SizedBox(height: 40),
        Divider(),
        Footer(isMobile: isMobile),
      ],
    );
  }
}
