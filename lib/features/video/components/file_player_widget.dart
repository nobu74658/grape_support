import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:grape_support/features/video/components/floating_action_button_widget.dart';
import 'package:grape_support/features/video/components/video_player_widget.dart';
import 'package:grape_support/primary/show_dialog.dart';
import 'package:video_player/video_player.dart';

class FilePlayerWidget extends StatefulWidget {
  const FilePlayerWidget({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _FilePlayerWidgetState createState() => _FilePlayerWidgetState();
}

class _FilePlayerWidgetState extends State<FilePlayerWidget> {
  File? file;
  VideoPlayerController? controller;

  @override
  void dispose() {
    unawaited(controller?.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: (controller == null)
            ? Container()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: VideoPlayerWidget(controller: controller!),
                ),
              ),
        floatingActionButton: buildAddButton(),
      );

  Widget buildAddButton() => Container(
        padding: const EdgeInsets.all(32),
        child: FloatingActionButtonWidget(
          onPressed: () async {
            unawaited(SD.circular(context));
            final file = await pickVideoFile();
            if (file == null) {
              Navigator.pop(context); // circular
              return;
            }

            await controller?.dispose();
            controller = VideoPlayerController.file(file)
              ..addListener(() => setState(() {}));
            unawaited(controller?.setLooping(true));
            unawaited(
              controller?.initialize().then((_) {
                controller?.setVolume(0);
                controller?.play();
                setState(() {});
              }).then(
                (value) => Navigator.pop(context), // circular
              ),
            );
          },
        ),
      );

  Future<File?> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null) {
      return null;
    }

    return File(result.files.single.path!);
  }
}
