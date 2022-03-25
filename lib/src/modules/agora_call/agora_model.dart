class AgoraModel {
  String? _channelName;
  String? _token;

  String? get channelName => _channelName;

  String? get token => _token;

  set channelName(String? name) {
    _channelName = name;
  }

  set token(String? name) {
    _token = name;
  }

  AgoraModel({String? channelName, String? token}) {
    _channelName = channelName;
    _token = token;
  }

  AgoraModel.fromJson(dynamic json) {
    _channelName = json["channel_name"];
    _token = json["token"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["channel_name"] = _channelName;
    map["token"] = _token;
    return map;
  }
}
