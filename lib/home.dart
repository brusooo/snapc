// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:snapc/uploadbtn.dart';
import 'package:snapc/bottomsheet.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:snapc/classifier/classifier.dart';
import 'package:snapc/detailspage.dart';
import 'package:snapc/buttons/appbutton.dart';
import 'package:google_fonts/google_fonts.dart';

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class HomePage extends StatefulWidget {
  final _labelsFileName = 'assets/tf_model/flower_labels.txt';
  final File modelFile;
  const HomePage({
    super.key,
    required this.modelFile,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;

  // Result
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _flowerLabel = ''; // Name of Error Message
  double _accuracy = 0.0;

  late Classifier _classifier;

  SnackBar _getSnackBar(String message) {
    return SnackBar(
      content: Text(
        message,
        style: GoogleFonts.josefinSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          textStyle: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      backgroundColor: Colors.blue.shade300,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  Future<void> _loadClassifier() async {
    debugPrint(
      'Start loading of Classifier with '
      'labels at ${widget._labelsFileName}, '
      'model at ${widget.modelFile.path}',
    );

    final classifier = await Classifier.loadWith(
        labelsFileName: widget._labelsFileName,
        modelFileName: widget.modelFile.path);
    _classifier = classifier!;
  }

  // image picker setting image path
  void _updateImageFile(String newImageFilePath) {
    setState(() {
      _image = File(newImageFilePath);
    });
    _analyzeImage(_image!);
  }

  void _analyzeImage(File image) {
    // _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final flowerLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    setState(() {
      _resultStatus = result;
      _flowerLabel = flowerLabel;
      _accuracy = accuracy;
    });
  }

  void _getBottomDrawer(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDrawer(
          imageFile: _image,
          updateImageFile: _updateImageFile,
        );
      },
    );
  }

  // for blue buttons
  ButtonStyle getBlueButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(40), //padding of outer Container
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 300, //height of inner container
                  width: double.infinity,
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Hero(
                            tag: 'imageToClassify',
                            child: Image.file(
                              _image!,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      : UploadBtn(
                          imageFile: _image,
                          updateImageFile: _updateImageFile,
                        ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _getBottomDrawer(context);
                      },
                      child: AppButton(
                          btnHeight: 45,
                          btnColor: Colors.blue.shade300,
                          btnText: 'Upload'),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _flowerLabel != ''
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                          imgPath: _image,
                                          imgName: _flowerLabel,
                                        )),
                              )
                            : ScaffoldMessenger.of(context).showSnackBar(
                                _getSnackBar('No Flower Found'),
                              );
                      },
                      child: AppButton(
                          btnHeight: 45,
                          btnColor: Colors.blue.shade300,
                          btnText: 'Info'),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
