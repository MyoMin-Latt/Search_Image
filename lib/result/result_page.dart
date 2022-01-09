import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_image_p1/response_ob/response_ob.dart';
import 'package:search_image_p1/result/result_bloc.dart';
import 'package:search_image_p1/result/result_ob.dart';
import 'package:search_image_p1/result/result_widget.dart';

class ResultPage extends StatefulWidget {
  String searchTextEC;
  ResultPage(this.searchTextEC, { Key? key }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  List<Hits> hitsList = [];
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  ResultBloc resultBloc = ResultBloc();
  @override
  void initState() {
    super.initState();
    resultBloc.resultData(widget.searchTextEC);
    resultBloc.resultStream().listen((ResponseOb responseOb) { 
      responseOb.msgState == MsgState.data;
      if(responseOb.pageState == PageState.first){
        _refreshController.refreshCompleted();
        _refreshController.resetNoData();
      }
      else if(responseOb.pageState == PageState.more){
        ResultOb resultOb = responseOb.data;
        if(resultOb.hits!.length<20){
          _refreshController.loadNoData();
        }
        else {
          _refreshController.loadComplete();
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchTextEC),
      ),
      body: StreamBuilder(
        stream: resultBloc.resultStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (BuildContext context, AsyncSnapshot<ResponseOb> snapshot){
          ResponseOb? responseOb = snapshot.data;
          if(responseOb!.msgState == MsgState.loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(responseOb.msgState == MsgState.data){
            ResultOb resultOb = responseOb.data;
            if(responseOb.pageState == PageState.first){
              hitsList = resultOb.hits!;
            }
            else if(responseOb.pageState == PageState.more){
              hitsList.addAll(resultOb.hits!);
            }
            // print(resultOb.hits!.length.toString()+' resultOb.hits!.length.above SrmartRefresher');
            // print(hitsList.length.toString()+' hitsList.length above SrmartRefresher');

            //SmartRefresher
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: (){
                resultBloc.resultData(widget.searchTextEC);
                print(hitsList.length.toString()+' onRefresh');
              },
              enablePullUp: resultOb.hits!.length==20,
              onLoading: (){
                resultBloc.resultMoreData(widget.searchTextEC);
                print(hitsList.length.toString()+' onLoading');
              },
              child: ListView.builder(
                itemCount: hitsList.length,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    children: [
                      // Text(
                      //   'Image Number '+(index+1).toString(),
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      ResultWidget(hitsList[index]),
                    ],
                  );
                }
              ),
            );
          }
          else{
            if(responseOb.errState == ErrState.serverErr){
              return Center(child: Text('Server Error'));
            }
            else if(responseOb.errState == ErrState.notFoundErr){
              return Center(child: Text('NotfoundErr'));
            }
            else{
              return Center(child: Text('UnkonwError'));
            }
          }
        },
      ),
    );
  }
  @override
  void dispose() {
    resultBloc.dispose();
    super.dispose();
  }
}