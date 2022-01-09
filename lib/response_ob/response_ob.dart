class ResponseOb{
  MsgState? msgState;
  ErrState? errState;
  dynamic data;
  PageState? pageState;
  ResponseOb({this.msgState, this.errState, this.data, this.pageState});
}
enum MsgState{
  loading,
  error,
  data,
}

enum ErrState{
  serverErr,
  notFoundErr,
  unknowErr,
}

enum PageState{
  first,
  more,
}