/// Status : true
/// success : 1
/// msg : "Successfully Updated Availability To  Inactive"

class ModelFlutterWave {
  ModelFlutterWave({
    bool? status,
    int? success,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _msg = msg;
  }

  ModelFlutterWave.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    map['msg'] = _msg;
    return map;
  }
}
