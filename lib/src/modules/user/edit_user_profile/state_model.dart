class StateModel {
  StateModel({
      bool? status, 
      num? success, 
      StateDataModel? data,
      String? msg,}){
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
}

  StateModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? StateDataModel.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  num? _success;
  StateDataModel? _data;
  String? _msg;
StateModel copyWith({  bool? status,
  num? success,
  StateDataModel? data,
  String? msg,
}) => StateModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  bool? get status => _status;
  num? get success => _success;
  StateDataModel? get data => _data;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = _status;
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['msg'] = _msg;
    return map;
  }

}

class StateDataModel {
  StateDataModel({
      List<States>? states,}){
    _states = states;
}

  StateDataModel.fromJson(dynamic json) {
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
  }
  List<States>? _states;
StateDataModel copyWith({  List<States>? states,
}) => StateDataModel(  states: states ?? _states,
);
  List<States>? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class States {
  States({
      num? id, 
      String? name, 
      num? countryId,}){
    _id = id;
    _name = name;
    _countryId = countryId;
}

  States.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryId = json['country_id'];
  }
  num? _id;
  String? _name;
  num? _countryId;
States copyWith({  num? id,
  String? name,
  num? countryId,
}) => States(  id: id ?? _id,
  name: name ?? _name,
  countryId: countryId ?? _countryId,
);
  num? get id => _id;
  String? get name => _name;
  num? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_id'] = _countryId;
    return map;
  }

}