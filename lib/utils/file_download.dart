import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

class FileDownload {
  String namaFile;
  String downloadUrl;
  FileDownload(this.namaFile, this.downloadUrl);

  Dio dio = Dio();
  bool isSuccess = false;

  void startDownloading(BuildContext context, final Function okCallback) async {
    String fileName = "dian_istana_" + namaFile;

    String baseUrl = downloadUrl;

    String path = await _getFilePath(fileName);

    try {
      await dio.download(
        baseUrl,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          okCallback(recivedBytes, totalBytes);
        },
        deleteOnError: true,
      ).then((_) {
        isSuccess = true;
      });
    } catch (e) {
      print("Exception$e");
    }

    if (isSuccess) {
      Navigator.pop(context);
    }
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory(); // for iOS
      } else {
        dir = Directory('/storage/emulated/0/Download/'); // for android
        if (!await dir.exists()) dir = (await getExternalStorageDirectory())!;
      }
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    print("${dir?.path}$filename");
    return "${dir?.path}$filename";
  }
}
