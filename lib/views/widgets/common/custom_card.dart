import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.withBorder = true,
    this.borderColor,
    this.borderRadius = 16,
    this.padding = const EdgeInsets.all(16.0),
    this.outerPadding = const EdgeInsets.all(8.0),
  });

  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  final Color? borderColor;
  final double borderRadius;
  final bool withBorder;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry outerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(borderRadius),
          border: withBorder
              ? Border.all(
                  color: borderColor ?? Colors.grey.shade300,
                  width: 0.5,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
