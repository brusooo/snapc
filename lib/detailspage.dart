import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class DetailsPage extends StatefulWidget {
  final File? imgPath;
  final String imgName;

  const DetailsPage({
    super.key,
    required this.imgPath,
    required this.imgName,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            elevation: 0,
            snap: true,
            floating: true,
            stretch: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
              ],
              background: Hero(
                transitionOnUserGestures: true,
                tag: 'imageToClassify',
                child: Image.file(
                  widget.imgPath!,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Transform.translate(
                  offset: const Offset(0, 1),
                  child: Container(
                    height: 45,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInUp(
                                from: 60,
                                child: Text(
                                  widget.imgName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // FadeInUp(
                              //   from: 70,
                              //   delay: Duration(milliseconds: 200),
                              //   child: const Text(
                              //     'If the back button is still not working after implementing the above solution, there may be a few possible causes. Here are some suggestions to try:',
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.w200,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
