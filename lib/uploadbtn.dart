import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapc/bottomsheet.dart';

class UploadBtn extends StatefulWidget {
  const UploadBtn({
    super.key,
    required this.imageFile,
    required this.updateImageFile,
  });

  final File? imageFile;
  final ValueChanged<String> updateImageFile;

  @override
  State<UploadBtn> createState() => _UploadBtnState();
}

class _UploadBtnState extends State<UploadBtn> {
  //image Picker

  void _getBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDrawer(
          imageFile: widget.imageFile,
          updateImageFile: widget.updateImageFile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _getBottomSheet();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(20),
        color: Colors.black38, //color of dotted/dash line
        strokeWidth: 3, //thickness of dash/dots
        dashPattern: const [10, 6],
        //dash patterns, 10 is dash width, 6 is space width
        child: SizedBox(
          //inner container
          height: 300, //height of inner container
          width: double.infinity, //width to 100% match to parent container.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/camera.png',
                scale: 1.5,
                color: Colors.black87,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'upload an image to predict',
                style: GoogleFonts.josefinSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
