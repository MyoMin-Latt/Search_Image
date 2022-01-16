

import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:search_image_p1/response_ob/response_ob.dart';

class DownloadImageBloc{
  StreamController<ResponseOb> streamControllerImage = StreamController();
  Stream<ResponseOb> streamImage() => streamControllerImage.stream;

  getDownloadImage() async {
    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    streamControllerImage.sink.add(responseOb);
    Directory? directory;
    directory = await getExternalStorageDirectory();
    Directory path = Directory(directory!.path+'/Images/');
    path.list().forEach((element) {
      print(element);
    });
    List<FileSystemEntity> downloadImageList = path.listSync();
    responseOb.msgState = MsgState.data;
    responseOb.data = downloadImageList;
    streamControllerImage.sink.add(responseOb);

  }

  dispose(){
    streamControllerImage.close();
  }
}