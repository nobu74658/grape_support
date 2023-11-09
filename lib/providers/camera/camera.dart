import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera.g.dart';

@Riverpod(keepAlive: true)
class Camera extends _$Camera {
  @override
  Future<CameraDescription> build() async {
    final cameras = await availableCameras();
    debugPrint('cameras: $cameras');
    return cameras.first;
  }
}
