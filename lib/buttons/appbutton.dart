import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppButton extends StatefulWidget {
  final double btnHeight;
  final Color btnColor;
  final String btnText;

  const AppButton({
    super.key,
    required this.btnHeight,
    required this.btnColor,
    required this.btnText,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: widget.btnHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.btnColor,
      ),
      child: Center(
        child: Text(
          widget.btnText,
          style: GoogleFonts.josefinSans(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
