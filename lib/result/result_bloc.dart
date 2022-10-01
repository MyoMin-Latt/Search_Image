import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:search_image_p1/response_ob/response_ob.dart';
import 'package:http/http.dart' as http;
import 'package:search_image_p1/result/result_ob.dart';
import 'package:search_image_p1/utlis/constant.dart';

class ResultBloc {
  final StreamController<ResponseOb> _controller = StreamController.broadcast();
  Stream<ResponseOb> resultStream() => _controller.stream;

  int pageNum = 1;
  resultData(String searchdata) async {
    pageNum = 1;
    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    // _controller.sink.add(responseOb);
    // print(Uri.parse(baseUrl+'?key='+pixaKey+'&q='+searchdata));
    // baseUrl+'?key='+pixaKey+'&q='+searchdata+'&page='+pageNum.toString()
    // check api link
    log(baseUrl +
        '?key=' +
        pixaKey +
        '&q=' +
        searchdata +
        '&page=' +
        pageNum.toString());
    var response = await http.get(Uri.parse(baseUrl +
        '?key=' +
        pixaKey +
        '&q=' +
        searchdata +
        '&page=' +
        pageNum.toString()));
    if (response.statusCode == 200) {
      /// check response data from api
      log('Response Data => \n ${response.body}');
      Map<String, dynamic> map = jsonDecode(response.body);

      /// To Change Json to Model [ResultOb]
      ResultOb resultOb = ResultOb.fromJson(map);
      log('Response Data Json to Model => \n ${response.body}');
      responseOb.msgState = MsgState.data;
      responseOb.data = resultOb;
      responseOb.pageState = PageState.first;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 404) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 500) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.serverErr;
      _controller.sink.add(responseOb);
    }
  }

  resultMoreData(String searchdata) async {
    pageNum++;
    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    // check api link
    // baseUrl+'?key='+pixaKey+'&q='+searchdata+'&page='+pageNum.toString()
    log(baseUrl +
        '?key=' +
        pixaKey +
        '&q=' +
        searchdata +
        '&page=' +
        pageNum.toString());
    var response = await http.get(Uri.parse(baseUrl +
        '?key=' +
        pixaKey +
        '&q=' +
        searchdata +
        '&page=' +
        pageNum.toString()));
    if (response.statusCode == 200) {
      /// check response data from api
      log(response.body);
      Map<String, dynamic> map = jsonDecode(response.body);

      /// To Change Json to Model [ResultOb]
      ResultOb resultOb = ResultOb.fromJson(map);
      log('Response Data Json to Model => \n ${response.body}');
      responseOb.msgState = MsgState.data;
      responseOb.data = resultOb;
      responseOb.pageState = PageState.more;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 404) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(responseOb);
    } else if (response.statusCode == 500) {
      responseOb.data = null;
      responseOb.msgState = MsgState.error;
      responseOb.errState = ErrState.serverErr;
      _controller.sink.add(responseOb);
    }
  }

  dispose() {
    _controller.close();
  }
}
