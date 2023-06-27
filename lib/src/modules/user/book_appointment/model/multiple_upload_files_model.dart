/// Status : true
/// success : 1
/// data : {"file_details":{"url":"assets/bookappointment/1681883707_Screenshot 2023-04-12 at 10.52.03 AM.png","name":"Screenshot 2023-04-12 at 10.52.03 AM.png","file_type":"png","size":22.64453125,"description":null,"booking_appointment_id":null,"updated_at":"2023-04-19T05:55:07.000000Z","created_at":"2023-04-19T05:55:07.000000Z","id":52}}
/// msg : "File Uploaded Successfully"

class MultipleUploadFilesModel {
  MultipleUploadFilesModel({
    this.status,
    this.success,
    this.data,
    this.msg,
  });

  MultipleUploadFilesModel.fromJson(dynamic json) {
    status = json['Status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }
  bool? status;
  int? success;
  Data? data;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['msg'] = msg;
    return map;
  }
}

/// file_details : {"url":"assets/bookappointment/1681883707_Screenshot 2023-04-12 at 10.52.03 AM.png","name":"Screenshot 2023-04-12 at 10.52.03 AM.png","file_type":"png","size":22.64453125,"description":null,"booking_appointment_id":null,"updated_at":"2023-04-19T05:55:07.000000Z","created_at":"2023-04-19T05:55:07.000000Z","id":52}

class Data {
  Data({
    this.fileDetails,
  });

  Data.fromJson(dynamic json) {
    fileDetails = json['file_details'] != null ? FileDetails.fromJson(json['file_details']) : null;
  }
  FileDetails? fileDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (fileDetails != null) {
      map['file_details'] = fileDetails?.toJson();
    }
    return map;
  }
}

/// url : "assets/bookappointment/1681883707_Screenshot 2023-04-12 at 10.52.03 AM.png"
/// name : "Screenshot 2023-04-12 at 10.52.03 AM.png"
/// file_type : "png"
/// size : 22.64453125
/// description : null
/// booking_appointment_id : null
/// updated_at : "2023-04-19T05:55:07.000000Z"
/// created_at : "2023-04-19T05:55:07.000000Z"
/// id : 52

class FileDetails {
  FileDetails({
    this.url,
    this.name,
    this.fileType,
    this.size,
    this.description,
    this.bookingAppointmentId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  FileDetails.fromJson(dynamic json) {
    url = json['url'];
    name = json['name'];
    fileType = json['file_type'];
    size = json['size'];
    description = json['description'] != null ? Data.fromJson(json['description']) : null;
    bookingAppointmentId = json['booking_appointment_id'] != null ? Data.fromJson(json['booking_appointment_id']) : null;
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
  String? url;
  String? name;
  String? fileType;
  double? size;
  dynamic description;
  dynamic bookingAppointmentId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['name'] = name;
    map['file_type'] = fileType;
    map['size'] = size;
    map['description'] = description;
    map['booking_appointment_id'] = bookingAppointmentId;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['id'] = id;
    return map;
  }
}
