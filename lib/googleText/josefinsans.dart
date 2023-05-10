import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoseFinSans extends StatelessWidget {
  final String txtMsg;
  final double txtSize;
  final FontWeight txtWeight;
  final double txtShadowOffset;
  final double txtHeight;
  final Color txtColor;


  const JoseFinSans({
    super.key,
    required this.txtMsg,
    required this.txtSize,
    required this.txtWeight,
    required this.txtShadowOffset,
    required this.txtHeight,
    required this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      txtMsg,
      style: GoogleFonts.josefinSans(
        shadows: [
          Shadow(
            offset: Offset(txtShadowOffset, txtShadowOffset),
          )
        ],
        fontSize: txtSize,
        fontWeight: txtWeight,
        height: txtHeight,
        color: txtColor
      ),
    );
  }
}
