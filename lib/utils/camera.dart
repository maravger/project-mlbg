import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starter_app/utils/object_list_item.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/services.dart' show rootBundle;


// TODO insert service ip here
Options options= new Options(
//  You can access your host machine with the IP address "10.0.2.2"
    baseUrl:"http://10.0.2.2:8000/ca_tf/imageUpload/",
    connectTimeout:5000,
    receiveTimeout:3000
);
Dio dio = new Dio(options);

String obj;
Function(String) notifyOL;
BuildContext context;

class CameraHome extends StatefulWidget {

  CameraHome(String objClass, Function notifyParent, BuildContext cont){
    // TODO: Find a better way to handle these
    obj = objClass;
    notifyOL = notifyParent;
    context = cont;
  }

  @override
  _CameraHomeState createState() {
    return new _CameraHomeState();
  }

}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw new ArgumentError('Unknown lens direction');
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class _CameraHomeState extends State<CameraHome> {
  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;
  List<CameraDescription> cameras;
  bool _isReady = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print("@@@init state");
    super.initState();
    _setupCameras();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) new CircularProgressIndicator();
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: const Text('Camera'),
        ),
        body: new Column(
          children: <Widget>[
            new Expanded(
              child: new Container(
                child: new Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: new Center(
                    child: _cameraPreviewWidget(),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.black,
                  border: new Border.all(
                    color: controller != null &&
                        controller.value.isRecordingVideo
                        ? Colors.redAccent
                        : Colors.grey,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            _captureControlRowWidget(),
            new Padding(
              padding: const EdgeInsets.all(5.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _cameraTogglesRowWidget(),
                ],
              ),
            ),
          ],
        ),
      );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new CameraPreview(controller),
      );
    }
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
                  controller.value.isInitialized &&
                  !controller.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
      ],
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    if (cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in cameras) {
        toggles.add(
          new SizedBox(
            width: 90.0,
            child: new RadioListTile<CameraDescription>(
              title:
                  new Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller != null && controller.value.isRecordingVideo
                  ? null
                  : onNewCameraSelected,
            ),
          ),
        );
      }
    }

    return new Row(children: toggles);
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = new CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> onTakePictureButtonPressed() async {
    // TODO pictures should not be saved
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoController?.dispose();
          videoController = null;
        });
        if (filePath != null) {
          //showInSnackBar('Picture saved to $filePath');
          mlUpload(File(filePath));
        }
      }
    }
    );
  }

  // That's where magic happens
  mlUpload(File imageFile) async {
    FormData formData = new FormData.from({
      "class": obj,
      "file": new UploadFileInfo(imageFile, 'n3.jpg')
    });
    // final Response response = await dio.post('n3.jpg', data: formData);
    // ideally something like this
    // resp = response.data
    // The service response
    bool resp = true;
    showInSnackBar('Searching for $obj');
    if (resp) {
      print("Im here");
      Navigator.pop(context);
      notifyOL(obj);
    } else {
      showInSnackBar('Try again!');
    }
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    print(extDir);
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
//    final String dirPath = '~/Desktop/';
    await new Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    // post data to tensorflow recognition service

    return filePath;
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  Future<void> reachAvailableCameras() async {
    // Fetch the available cameras before initializing the app.
    print("!!!waiting for cameras");
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  Future<void> _setupCameras() async {
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
    setState(() {
      _isReady = true;
    });
  }

}