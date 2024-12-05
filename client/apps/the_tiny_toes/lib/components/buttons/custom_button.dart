import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.bg = const Color(0xFFFDBF04),
    this.border = const Color(0xFFFDBF04),
    this.borderWidth = 0,
    this.fontColor = Colors.white,
    this.fontSize = 17,
    required this.onTap,
    super.key,
    required this.size,
  });

  final Size size;
  final String text;
  final Color bg;
  final Color border;
  final Color fontColor;
  final double borderWidth;
  final double fontSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width - 20,
        height: 50,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
            ],
            border: Border.all(
              color: border,
              width: borderWidth,
            ),
            color: bg,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
            child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text,
              style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )),
      ),
    );
  }
}
