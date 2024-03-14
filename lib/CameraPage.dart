import 'dart:async';

import 'package:camapp/PhotoPreview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  CameraPage({super.key, required this.cameralist});
  List<CameraDescription> cameralist;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  int selectedtimer = 0;
  int timertime = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera(widget.cameralist[0]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  startTimer() {
    Timer(
        Duration(
            seconds: selectedtimer == 1
                ? 5
                : selectedtimer == 2
                    ? 10
                    : 15), () {
      takePicture();
      setState(() {
        selectedtimer = 0;
        timertime = 0;
      });
    });
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController.takePicture();
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhotoPreview(
                    image: picture,
                  )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _cameraController.value.isInitialized
            ? Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CameraPreview(_cameraController),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Divider(
                              endIndent: 50,
                              indent: 50,
                              color: Color.fromARGB(174, 255, 0, 0),
                              thickness: 2,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 400,
                            ),
                            const Divider(
                              endIndent: 50,
                              indent: 50,
                              color: Color.fromARGB(174, 255, 0, 0),
                              thickness: 2,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Expanded(child: SizedBox()),
                    //Center(
                    // child:
                    //  Text(timertime == 0 ? "" : timertime.toString())),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (selectedtimer == 0) {
                              setState(() {
                                selectedtimer = 1;
                              });
                              startTimer();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedtimer == 1
                                    ? const Color.fromARGB(255, 54, 54, 54)
                                    : Colors.white,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "5s",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: selectedtimer != 1
                                    ? const Color.fromARGB(255, 34, 34, 34)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedtimer == 0) {
                              setState(() {
                                selectedtimer = 2;
                              });
                              startTimer();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedtimer == 2
                                    ? const Color.fromARGB(255, 54, 54, 54)
                                    : Colors.white,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "10s",
                              style: TextStyle(
                                  color: selectedtimer != 2
                                      ? const Color.fromARGB(255, 34, 34, 34)
                                      : Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (selectedtimer == 0) {
                              setState(() {
                                selectedtimer = 3;
                              });
                              startTimer();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selectedtimer == 3
                                    ? const Color.fromARGB(255, 54, 54, 54)
                                    : Colors.white,
                                border: Border.all(width: 2),
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "15s",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: selectedtimer != 3
                                    ? const Color.fromARGB(255, 34, 34, 34)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                const Color.fromARGB(255, 77, 77, 77),
                            child: IconButton(
                              icon: const Icon(
                                Icons.camera,
                                color: Color.fromARGB(255, 255, 255, 255),
                                size: 45,
                              ),
                              onPressed: takePicture,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                const Color.fromARGB(255, 77, 77, 77),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.cameraswitch_sharp,
                                size: 30,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() => _isRearCameraSelected =
                                    !_isRearCameraSelected);
                                initCamera(widget
                                    .cameralist[_isRearCameraSelected ? 0 : 1]);
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
