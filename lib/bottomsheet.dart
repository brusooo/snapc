import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BottomSheetDrawer extends StatefulWidget {
  const BottomSheetDrawer({
    super.key,
    required this.imageFile,
    required this.updateImageFile,
  });

  final File? imageFile;
  final ValueChanged<String> updateImageFile;

  @override
  State<BottomSheetDrawer> createState() => _BottomSheetDrawerState();
}

class _BottomSheetDrawerState extends State<BottomSheetDrawer> {
  final _picker = ImagePicker();

  Future<void> _openImagePicker(imageFile, method) async {
    final XFile? pickedImage = await _picker.pickImage(source: method);
    if (pickedImage != null) {
      widget.updateImageFile(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 180,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(13, 9, 9,
                          15)), // set the width and color of the bottom border
                ),
              ),
              width: double.infinity,
              height: 60,
              child: Center(
                child: Text(
                  'Choose Source',
                  style: GoogleFonts.josefinSans(
                      color: Colors.black45,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      textStyle: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 1.0,
                      color: Color.fromARGB(13, 9, 9,
                          15)), // set the width and color of the bottom border
                ),
              ),
              width: double.infinity,
              height: 60,
              child: GestureDetector(
                onTap: () {
                  _openImagePicker(
                    widget.imageFile,
                    ImageSource.gallery,
                  );
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Gallery',
                    style: GoogleFonts.josefinSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: GestureDetector(
                onTap: () {
                  _openImagePicker(
                    widget.imageFile,
                    ImageSource.camera,
                  );
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Camera',
                    style: GoogleFonts.josefinSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textStyle: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
