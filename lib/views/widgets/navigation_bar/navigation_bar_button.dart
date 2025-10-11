import 'package:flutter/material.dart';

class CustomNavigationBarButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const CustomNavigationBarButton({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  @override
  State<CustomNavigationBarButton> createState() =>
      _CustomNavigationBarButtonState();
}

class _CustomNavigationBarButtonState extends State<CustomNavigationBarButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.colorScheme.primary.withAlpha(10)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? widget.colorScheme.primary
                  : Colors.grey[600],
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: widget.isSelected
                    ? widget.colorScheme.primary
                    : Colors.grey[600],
                fontWeight: widget.isSelected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
