import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:snapc/googleText/josefinsans.dart';
import 'package:snapc/home.dart';
import 'package:snapc/rive/animated_btn.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbodingScreen extends StatefulWidget {
  final File homeModelFile;
  const OnbodingScreen({super.key, required this.homeModelFile});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  StateMachineController? controller;
  SMIInput<double>? inputValue;

  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  void _setCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('counter', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.83,
                    bottom: 0,
                    right: 0,
                    child: RiveAnimation.asset(
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      "assets/rive/tree_demo.riv",
                      onInit: (artboard) {
                        controller = StateMachineController.fromArtboard(
                          artboard,
                          "State Machine 1",
                        );

                        if (controller != null) {
                          artboard.addController(controller!);
                          inputValue = controller?.findInput("input");
                          inputValue?.change(100);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    bottom: 0,
                    child: const RiveAnimation.asset(
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.cover,
                      "assets/rive/flowers_composition_tutorial.riv",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: const SizedBox(),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          JoseFinSans(
                            txtMsg: "Visualize Identify & Classify",
                            txtSize: 48,
                            txtWeight: FontWeight.w700,
                            txtShadowOffset: 2,
                            txtHeight: 1.2,
                            txtColor: Colors.black,
                          ),
                          SizedBox(height: 16),
                          JoseFinSans(
                            txtMsg:
                                "Discover the power of visual recognition with our image classification app. Fast, accurate, and easy to use.",
                            txtSize: 15,
                            txtWeight: FontWeight.w600,
                            txtShadowOffset: 0,
                            txtHeight: 0,
                            txtColor: Colors.black54,
                          )
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 1000),
                          () {
                            Get.to(
                                () => HomePage(
                                      modelFile: widget.homeModelFile,
                                    ),
                                transition: Transition.zoom);
                          },
                        );
                      },
                    ),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: JoseFinSans(
                          txtMsg:
                              "Unlock the power of visual recognition with our applicarion - Explore the world of Nature",
                          txtSize: 15,
                          txtWeight: FontWeight.w600,
                          txtShadowOffset: 0,
                          txtHeight: 0,
                          txtColor: Colors.black38,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
