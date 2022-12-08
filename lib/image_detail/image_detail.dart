// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';

import 'package:search_image_p1/result/result_ob.dart';

class ImageDetailPage extends StatefulWidget {
  final Hits hits;

  const ImageDetailPage({Key? key, required this.hits}) : super(key: key);

  // final GlobalKey _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Detail'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              imageUrl: widget.hits.webformatURL!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      widget.hits.likes.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      widget.hits.views.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      Icons.download,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      widget.hits.downloads.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            isDownloading
                ? ElevatedButton.icon(
                    onPressed: () {
                      downLoadImage();
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'))
                : Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: LiquidCircularProgressIndicator(
                        value: int.parse(count) / 100, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Theme.of(context)
                            .primaryColor), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors
                            .white, // Defaults to the current Theme's backgroundColor.
                        borderColor: Theme.of(context).primaryColor,
                        borderWidth: 5.0,
                        direction: Axis
                            .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text(count + ' %'),
                      ),
                    ),
                  ),
          ],
        ));
  }

  bool isDownloading = true;
  String count = '0';
  void downLoadImage() async {
    log('Image URL Link : ${widget.hits.largeImageURL.toString()}');
    setState(() {
      isDownloading = false;
    });
    Directory? directory;
    directory = await getExternalStorageDirectory();
    // String path = directory!.path + '/Images/' + DateTime.now().microsecond.toString()+basename(widget.hits.largeImageURL);
    String path = directory!.path +
        '/Images/' +
        widget.hits.largeImageURL!.split('/').last;
    await Dio().download(widget.hits.largeImageURL!, path,
        onReceiveProgress: (receive, total) {
      double percent = receive / total * 100;
      // print(percent.toStringAsFixed(0));
      setState(() {
        count = percent.toStringAsFixed(0);
      });
      if (percent == 100) {
        setState(() {
          isDownloading = true;
          count = '0';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          action: SnackBarAction(
              textColor: Colors.white, label: 'Ok', onPressed: () {}),
          content: const Text('Download is successful'),
        ));
      }
    });
  }
}
