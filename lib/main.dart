import 'package:camapp/CameraPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var cameras;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializecamera();
  }

  initializecamera() async {
    cameras = await availableCameras().then(
      (value) => Navigator.push(context,
          MaterialPageRoute(builder: (_) => CameraPage(cameralist: value))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        ),
      ),
    );
  }
}
