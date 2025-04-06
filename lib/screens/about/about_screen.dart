import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/shared/education_card.dart';
import 'package:flutter_web_portfolio/shared/expereince_card.dart';
import 'package:flutter_web_portfolio/shared/footer.dart';
import 'package:flutter_web_portfolio/shared/skill_chip.dart';

class AboutScreenUI extends StatefulWidget {
  const AboutScreenUI({super.key, required this.isDarkMode, required this.toggleTheme});
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  static const id = 'about_screen';

  @override
  State<AboutScreenUI> createState() => _AboutScreenUIState();
}

class _AboutScreenUIState extends State<AboutScreenUI> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 800;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: isMobile ? 24 : 35, left: isMobile ? 10 : 350, right: isMobile ? 10 : 350, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mozammel Hoshen Chowdhury',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Software Engineer',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: isMobile ? 30 : 60,
                backgroundColor: Colors.blue.shade100,
                backgroundImage: AssetImage('assets/images/mine.png'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Hello!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            "My name is Mozammel, and I am a passionate software engineer with expertise in Flutter development, backend API design, and scalable web solutions. "
            "With years of experience, I have built efficient, high-performance applications tailored to business needs.",
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 10),
          Text(
            "Currently, I am focused on building intuitive mobile and web applications, leveraging my knowledge of Flutter, Bloc state management, and REST APIs. "
            "I am always eager to explore new technologies and contribute to innovative projects that make a real impact.",
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 20),
          Text(
            'Technical Expertise',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
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
              SkillChip(
                label: 'GitHub',
                icon: Icons.code_rounded,
                accentColor: Colors.purple,
                isDarkMode: widget.isDarkMode,
              ),
              SkillChip(
                label: 'Linux',
                icon: Icons.terminal,
                accentColor: Colors.grey.shade700,
                isDarkMode: widget.isDarkMode,
              ),
            ],
          ),
          SizedBox(height: 20),

          Text(
            'Experience',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
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
          SizedBox(height: 20),
          Text(
            'Education',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 10),
          EducationCard(
            name: 'Daffodil International University',
            degree: 'Bachelor of Science in Computer Science',
            address: 'Dhaka, Bangladesh',
            duration: '2017 - 2022',
            imagePath: 'assets/images/diu.jpg',
            isDarkMode: widget.isDarkMode,
          ),
          const SizedBox(height: 10),
          EducationCard(
            name: 'Ibn Taimiya School and College',
            degree: 'Higher Secondary Certificate (HSC)',
            address: 'Comilla, Bangladesh',
            duration: '2015 - 2017',
            imagePath: 'assets/images/ibn.png',
            isDarkMode: widget.isDarkMode,
          ),
          const SizedBox(height: 40),
          Divider(),
          Footer(isMobile: isMobile),
        ],
      ),
    );
  }
}
