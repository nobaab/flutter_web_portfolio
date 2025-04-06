import 'package:flutter/material.dart';

class GlowButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color glowColor;
  final Color textColor;
  final VoidCallback onPressed;

  const GlowButton({
    super.key,
    required this.text,
    required this.icon,
    required this.glowColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 60,
          width: 250,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(_isHovered ? 0.5 : 0.3),
                blurRadius: 10,
                spreadRadius: _isHovered ? 5 : 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: widget.glowColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(widget.icon, color: widget.glowColor, size: 22),
              ),
              const SizedBox(width: 16),
              Text(widget.text, style: TextStyle(color: widget.textColor, fontSize: 18, fontWeight: FontWeight.w500)),
              const Spacer(),
              Text("→", style: TextStyle(color: widget.textColor, fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
