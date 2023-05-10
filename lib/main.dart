import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:snapc/rive/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:snapc/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ClassifierMain());
}

class ClassifierMain extends StatefulWidget {
  const ClassifierMain({super.key});

  @override
  State<ClassifierMain> createState() => _ClassifierMainState();
}

class _ClassifierMainState extends State<ClassifierMain> {
  bool _counter = true;
  File? localModelPath;
  @override
  void initState() {
    FirebaseModelDownloader.instance
        .getModel(
            "snapC",
            FirebaseModelDownloadType.localModel,
            FirebaseModelDownloadConditions(
              iosAllowsCellularAccess: true,
              iosAllowsBackgroundDownloading: false,
              androidChargingRequired: false,
              androidWifiRequired: false,
              androidDeviceIdleRequired: false,
            ))
        .then((customModel) {
      localModelPath = customModel.file;
    });
    super.initState();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getBool('counter') ?? true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _counter
          ? OnbodingScreen(homeModelFile: localModelPath!)
          : HomePage(modelFile: localModelPath!),
    );
    ;
  }
}
