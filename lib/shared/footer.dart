import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final bool isMobile;

  const Footer({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Footer content with copyright and social links
        isMobile
            ? Column(children: [_buildCopyrightSection(context), const SizedBox(height: 16), _buildSocialLinks(context)])
            : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildCopyrightSection(context), _buildSocialLinks(context)],
            ),
      ],
    );
  }

  Widget _buildCopyrightSection(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.diamond, color: Theme.of(context).colorScheme.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          "© ${DateTime.now().year} Mozammel",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), fontSize: 14),
        ),

        const SizedBox(width: 4),
        Text(
          "Have a good ${DateFormat('EEEE').format(DateTime.now())}!",
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLanguageDropdown(context),
        const SizedBox(width: 16),
        _buildSocialIcon(context, FontAwesome.github, "GitHub", "https://github.com/nobaab"),
        const SizedBox(width: 12),
        _buildSocialIcon(context, FontAwesome.linkedin_squared, "LinkedIn", "https://www.linkedin.com/in/mozammel.me"),
        const SizedBox(width: 12),
        _buildSocialIcon(context, FontAwesome.twitter_squared, "Twitter/X", "https://x.com/nobaabc"),
        const SizedBox(width: 12),
        _buildSocialIcon(context, FontAwesome.instagram, "Instagram", "https://www.instagram.com/mozammel.me"),
      ],
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.language, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text("English", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurfaceVariant)),
          Icon(Icons.arrow_drop_down, size: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(BuildContext context, IconData icon, String label, String profileUrl) {
    return IconButton(
      icon: Icon(icon, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7), size: 20),
      onPressed: () {
        final Uri url = Uri.parse(profileUrl);
        launchUrl(
          url,
          webOnlyWindowName: '_blank', // Open in new browser tab
        );
      },
      tooltip: label,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    );
  }
}
