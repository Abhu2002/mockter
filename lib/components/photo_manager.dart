import 'dart:typed_data';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/material.dart';

Future<void> saveImageWithPhotoManager(
    BuildContext context,
    ByteData byteData,
    ) async {
  // Request permission
  final PermissionState permission =
  await PhotoManager.requestPermissionExtend();

  if (!permission.isAuth) {
    // Permission denied
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Permission denied to save image')),
    );
    return;
  }

  final Uint8List bytes = byteData.buffer.asUint8List();

  // Save image
  final AssetEntity? entity =
  await PhotoManager.editor.saveImage(
    bytes,
    title: 'result_${DateTime.now().millisecondsSinceEpoch}', filename: 'result',
  );

  if (entity != null) {
    // SUCCESS
    SuccessAlertBox(
      context: context,
      title: 'PHOTO SAVED SUCCESSFULLY',
      messageText: 'Your result has been saved successfully in gallery',
      buttonColor: const Color(0xFF791eff),
    );
  } else {
    // FAILURE
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to save image')),
    );
  }
}
