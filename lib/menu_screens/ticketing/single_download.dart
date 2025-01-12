import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_file_safe/open_file_safe.dart';

class SingleDownloadScreen extends StatefulWidget {
  final String link_url;
  const SingleDownloadScreen({Key? key, required this.link_url})
      : super(key: key);

  @override
  State<SingleDownloadScreen> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<SingleDownloadScreen> {
  TextEditingController url = TextEditingController();
  double? _progress;

  @override
  void initState() {
    super.initState();
    url.text = widget.link_url;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("images/white_bg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Download File',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 20,
                ),
                TextField(
                  readOnly: true,
                  controller: url,
                  decoration: const InputDecoration(label: Text('Url*')),
                ),
                const SizedBox(height: 16),
                _progress != null
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          FileDownloader.downloadFile(
                              url: url.text.trim(),
                              onProgress: (name, progress) {
                                setState(() {
                                  _progress = progress;
                                });
                              },
                              onDownloadCompleted: (value) {
                                print('path  $value ');
                                OpenFile.open(value);
                                setState(() {
                                  _progress = null;
                                });
                              });
                        },
                        child: const Text('Download')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
