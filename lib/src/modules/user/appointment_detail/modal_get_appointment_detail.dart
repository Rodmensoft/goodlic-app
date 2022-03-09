/// Status : true
/// success : 1
/// data : {"appointment":{"id":2,"mentee_id":20,"mentor_id":9,"date":null,"time":null,"payment":120,"is_paid":0,"payment_status_code":"199","payment_response_msg":"Sorry! Your transaction was not successful. Please try again later.","payment_order_ref":"","payment_id":0,"appointment_type_string":"chat","appointment_type_id":3,"questions":"M Naveed Abbas","file":"","file_type":"","appointment_status":0,"refund":0,"created_at":"2022-02-07T04:57:58.000000Z","updated_at":"2022-02-07T04:59:57.000000Z","mentee_visibility":1,"mentor":{"id":9,"first_name":"Hassan","last_name":"ALi","email":"dads@gmail.com","phone":"923467799277","image_path":"https://mashvara.s3.ap-southeast-1.amazonaws.com/mentor/mZHwINcz8Cf9iajt86ZXu5Nohx29PVMbSIE7Kuuc.jpg","country":1,"city":"Faisalabad","address":"millat town","postal_code":null,"is_otp_verified":null,"father_name":"M Naseer Saleemi","cnic":"3330325893652","gender":"male","religion":"islam","dob":"1992-09-07","occupation":1,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-04T17:37:55.000000Z","updated_at":"2022-02-11T14:48:52.000000Z"},"mentee":{"id":20,"first_name":null,"last_name":null,"email":null,"phone":"923448480562","image_path":null,"country":null,"city":null,"address":null,"postal_code":null,"is_otp_verified":null,"father_name":null,"cnic":null,"gender":null,"religion":null,"dob":null,"occupation":null,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-07T04:56:24.000000Z","updated_at":"2022-02-07T21:49:33.000000Z"}}}
/// msg : "Appointment detail got Successfully"

class ModalGetAppointmentDetail {
  ModalGetAppointmentDetail({
    bool? status,
    int? success,
    ModalGetAppointmentDetailData? data,
    String? msg,
  }) {
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
  }

  ModalGetAppointmentDetail.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null
        ? ModalGetAppointmentDetailData.fromJson(json['data'])
        : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  ModalGetAppointmentDetailData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  ModalGetAppointmentDetailData? get data => _data;
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

/// appointment : {"id":2,"mentee_id":20,"mentor_id":9,"date":null,"time":null,"payment":120,"is_paid":0,"payment_status_code":"199","payment_response_msg":"Sorry! Your transaction was not successful. Please try again later.","payment_order_ref":"","payment_id":0,"appointment_type_string":"chat","appointment_type_id":3,"questions":"M Naveed Abbas","file":"","file_type":"","appointment_status":0,"refund":0,"created_at":"2022-02-07T04:57:58.000000Z","updated_at":"2022-02-07T04:59:57.000000Z","mentee_visibility":1,"mentor":{"id":9,"first_name":"Hassan","last_name":"ALi","email":"dads@gmail.com","phone":"923467799277","image_path":"https://mashvara.s3.ap-southeast-1.amazonaws.com/mentor/mZHwINcz8Cf9iajt86ZXu5Nohx29PVMbSIE7Kuuc.jpg","country":1,"city":"Faisalabad","address":"millat town","postal_code":null,"is_otp_verified":null,"father_name":"M Naseer Saleemi","cnic":"3330325893652","gender":"male","religion":"islam","dob":"1992-09-07","occupation":1,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-04T17:37:55.000000Z","updated_at":"2022-02-11T14:48:52.000000Z"},"mentee":{"id":20,"first_name":null,"last_name":null,"email":null,"phone":"923448480562","image_path":null,"country":null,"city":null,"address":null,"postal_code":null,"is_otp_verified":null,"father_name":null,"cnic":null,"gender":null,"religion":null,"dob":null,"occupation":null,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-07T04:56:24.000000Z","updated_at":"2022-02-07T21:49:33.000000Z"}}

class ModalGetAppointmentDetailData {
  ModalGetAppointmentDetailData({
    Appointment? appointment,
  }) {
    _appointment = appointment;
  }

  ModalGetAppointmentDetailData.fromJson(dynamic json) {
    _appointment = json['appointment'] != null
        ? Appointment.fromJson(json['appointment'])
        : null;
  }
  Appointment? _appointment;

  Appointment? get appointment => _appointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appointment != null) {
      map['appointment'] = _appointment?.toJson();
    }
    return map;
  }
}

/// id : 2
/// mentee_id : 20
/// mentor_id : 9
/// date : null
/// time : null
/// payment : 120
/// is_paid : 0
/// payment_status_code : "199"
/// payment_response_msg : "Sorry! Your transaction was not successful. Please try again later."
/// payment_order_ref : ""
/// payment_id : 0
/// appointment_type_string : "chat"
/// appointment_type_id : 3
/// questions : "M Naveed Abbas"
/// file : ""
/// file_type : ""
/// appointment_status : 0
/// refund : 0
/// created_at : "2022-02-07T04:57:58.000000Z"
/// updated_at : "2022-02-07T04:59:57.000000Z"
/// mentee_visibility : 1
/// mentor : {"id":9,"first_name":"Hassan","last_name":"ALi","email":"dads@gmail.com","phone":"923467799277","image_path":"https://mashvara.s3.ap-southeast-1.amazonaws.com/mentor/mZHwINcz8Cf9iajt86ZXu5Nohx29PVMbSIE7Kuuc.jpg","country":1,"city":"Faisalabad","address":"millat town","postal_code":null,"is_otp_verified":null,"father_name":"M Naseer Saleemi","cnic":"3330325893652","gender":"male","religion":"islam","dob":"1992-09-07","occupation":1,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-04T17:37:55.000000Z","updated_at":"2022-02-11T14:48:52.000000Z"}
/// mentee : {"id":20,"first_name":null,"last_name":null,"email":null,"phone":"923448480562","image_path":null,"country":null,"city":null,"address":null,"postal_code":null,"is_otp_verified":null,"father_name":null,"cnic":null,"gender":null,"religion":null,"dob":null,"occupation":null,"online_status":"offline","admin_user":0,"fb_id":null,"google_id":null,"created_at":"2022-02-07T04:56:24.000000Z","updated_at":"2022-02-07T21:49:33.000000Z"}

class Appointment {
  Appointment({
    int? id,
    int? menteeId,
    int? mentorId,
    dynamic date,
    dynamic time,
    int? payment,
    int? isPaid,
    String? paymentStatusCode,
    String? paymentResponseMsg,
    String? paymentOrderRef,
    int? paymentId,
    String? appointmentTypeString,
    int? appointmentTypeId,
    String? questions,
    String? file,
    String? fileType,
    int? appointmentStatus,
    int? refund,
    String? createdAt,
    String? updatedAt,
    int? menteeVisibility,
    Mentor? mentor,
    Mentee? mentee,
  }) {
    _id = id;
    _menteeId = menteeId;
    _mentorId = mentorId;
    _date = date;
    _time = time;
    _payment = payment;
    _isPaid = isPaid;
    _paymentStatusCode = paymentStatusCode;
    _paymentResponseMsg = paymentResponseMsg;
    _paymentOrderRef = paymentOrderRef;
    _paymentId = paymentId;
    _appointmentTypeString = appointmentTypeString;
    _appointmentTypeId = appointmentTypeId;
    _questions = questions;
    _file = file;
    _fileType = fileType;
    _appointmentStatus = appointmentStatus;
    _refund = refund;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _menteeVisibility = menteeVisibility;
    _mentor = mentor;
    _mentee = mentee;
  }

  Appointment.fromJson(dynamic json) {
    _id = json['id'];
    _menteeId = json['mentee_id'];
    _mentorId = json['mentor_id'];
    _date = json['date'];
    _time = json['time'];
    _payment = json['payment'];
    _isPaid = json['is_paid'];
    _paymentStatusCode = json['payment_status_code'];
    _paymentResponseMsg = json['payment_response_msg'];
    _paymentOrderRef = json['payment_order_ref'];
    _paymentId = json['payment_id'];
    _appointmentTypeString = json['appointment_type_string'];
    _appointmentTypeId = json['appointment_type_id'];
    _questions = json['questions'];
    _file = json['file'];
    _fileType = json['file_type'];
    _appointmentStatus = json['appointment_status'];
    _refund = json['refund'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _menteeVisibility = json['mentee_visibility'];
    _mentor = json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null;
    _mentee = json['mentee'] != null ? Mentee.fromJson(json['mentee']) : null;
  }
  int? _id;
  int? _menteeId;
  int? _mentorId;
  dynamic _date;
  dynamic _time;
  int? _payment;
  int? _isPaid;
  String? _paymentStatusCode;
  String? _paymentResponseMsg;
  String? _paymentOrderRef;
  int? _paymentId;
  String? _appointmentTypeString;
  int? _appointmentTypeId;
  String? _questions;
  String? _file;
  String? _fileType;
  int? _appointmentStatus;
  int? _refund;
  String? _createdAt;
  String? _updatedAt;
  int? _menteeVisibility;
  Mentor? _mentor;
  Mentee? _mentee;

  int? get id => _id;
  int? get menteeId => _menteeId;
  int? get mentorId => _mentorId;
  dynamic get date => _date;
  dynamic get time => _time;
  int? get payment => _payment;
  int? get isPaid => _isPaid;
  String? get paymentStatusCode => _paymentStatusCode;
  String? get paymentResponseMsg => _paymentResponseMsg;
  String? get paymentOrderRef => _paymentOrderRef;
  int? get paymentId => _paymentId;
  String? get appointmentTypeString => _appointmentTypeString;
  int? get appointmentTypeId => _appointmentTypeId;
  String? get questions => _questions;
  String? get file => _file;
  String? get fileType => _fileType;
  int? get appointmentStatus => _appointmentStatus;
  int? get refund => _refund;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get menteeVisibility => _menteeVisibility;
  Mentor? get mentor => _mentor;
  Mentee? get mentee => _mentee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentee_id'] = _menteeId;
    map['mentor_id'] = _mentorId;
    map['date'] = _date;
    map['time'] = _time;
    map['payment'] = _payment;
    map['is_paid'] = _isPaid;
    map['payment_status_code'] = _paymentStatusCode;
    map['payment_response_msg'] = _paymentResponseMsg;
    map['payment_order_ref'] = _paymentOrderRef;
    map['payment_id'] = _paymentId;
    map['appointment_type_string'] = _appointmentTypeString;
    map['appointment_type_id'] = _appointmentTypeId;
    map['questions'] = _questions;
    map['file'] = _file;
    map['file_type'] = _fileType;
    map['appointment_status'] = _appointmentStatus;
    map['refund'] = _refund;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['mentee_visibility'] = _menteeVisibility;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    if (_mentee != null) {
      map['mentee'] = _mentee?.toJson();
    }
    return map;
  }
}

/// id : 20
/// first_name : null
/// last_name : null
/// email : null
/// phone : "923448480562"
/// image_path : null
/// country : null
/// city : null
/// address : null
/// postal_code : null
/// is_otp_verified : null
/// father_name : null
/// cnic : null
/// gender : null
/// religion : null
/// dob : null
/// occupation : null
/// online_status : "offline"
/// admin_user : 0
/// fb_id : null
/// google_id : null
/// created_at : "2022-02-07T04:56:24.000000Z"
/// updated_at : "2022-02-07T21:49:33.000000Z"

class Mentee {
  Mentee({
    int? id,
    dynamic firstName,
    dynamic lastName,
    dynamic email,
    String? phone,
    dynamic imagePath,
    dynamic country,
    dynamic city,
    dynamic address,
    dynamic postalCode,
    dynamic isOtpVerified,
    dynamic fatherName,
    dynamic cnic,
    dynamic gender,
    dynamic religion,
    dynamic dob,
    dynamic occupation,
    String? onlineStatus,
    int? adminUser,
    dynamic fbId,
    dynamic googleId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _imagePath = imagePath;
    _country = country;
    _city = city;
    _address = address;
    _postalCode = postalCode;
    _isOtpVerified = isOtpVerified;
    _fatherName = fatherName;
    _cnic = cnic;
    _gender = gender;
    _religion = religion;
    _dob = dob;
    _occupation = occupation;
    _onlineStatus = onlineStatus;
    _adminUser = adminUser;
    _fbId = fbId;
    _googleId = googleId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Mentee.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _imagePath = json['image_path'];
    _country = json['country'];
    _city = json['city'];
    _address = json['address'];
    _postalCode = json['postal_code'];
    _isOtpVerified = json['is_otp_verified'];
    _fatherName = json['father_name'];
    _cnic = json['cnic'];
    _gender = json['gender'];
    _religion = json['religion'];
    _dob = json['dob'];
    _occupation = json['occupation'];
    _onlineStatus = json['online_status'];
    _adminUser = json['admin_user'];
    _fbId = json['fb_id'];
    _googleId = json['google_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _email;
  String? _phone;
  dynamic _imagePath;
  dynamic _country;
  dynamic _city;
  dynamic _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  dynamic _fatherName;
  dynamic _cnic;
  dynamic _gender;
  dynamic _religion;
  dynamic _dob;
  dynamic _occupation;
  String? _onlineStatus;
  int? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get email => _email;
  String? get phone => _phone;
  dynamic get imagePath => _imagePath;
  dynamic get country => _country;
  dynamic get city => _city;
  dynamic get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  dynamic get fatherName => _fatherName;
  dynamic get cnic => _cnic;
  dynamic get gender => _gender;
  dynamic get religion => _religion;
  dynamic get dob => _dob;
  dynamic get occupation => _occupation;
  String? get onlineStatus => _onlineStatus;
  int? get adminUser => _adminUser;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image_path'] = _imagePath;
    map['country'] = _country;
    map['city'] = _city;
    map['address'] = _address;
    map['postal_code'] = _postalCode;
    map['is_otp_verified'] = _isOtpVerified;
    map['father_name'] = _fatherName;
    map['cnic'] = _cnic;
    map['gender'] = _gender;
    map['religion'] = _religion;
    map['dob'] = _dob;
    map['occupation'] = _occupation;
    map['online_status'] = _onlineStatus;
    map['admin_user'] = _adminUser;
    map['fb_id'] = _fbId;
    map['google_id'] = _googleId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

/// id : 9
/// first_name : "Hassan"
/// last_name : "ALi"
/// email : "dads@gmail.com"
/// phone : "923467799277"
/// image_path : "https://mashvara.s3.ap-southeast-1.amazonaws.com/mentor/mZHwINcz8Cf9iajt86ZXu5Nohx29PVMbSIE7Kuuc.jpg"
/// country : 1
/// city : "Faisalabad"
/// address : "millat town"
/// postal_code : null
/// is_otp_verified : null
/// father_name : "M Naseer Saleemi"
/// cnic : "3330325893652"
/// gender : "male"
/// religion : "islam"
/// dob : "1992-09-07"
/// occupation : 1
/// online_status : "offline"
/// admin_user : 0
/// fb_id : null
/// google_id : null
/// created_at : "2022-02-04T17:37:55.000000Z"
/// updated_at : "2022-02-11T14:48:52.000000Z"

class Mentor {
  Mentor({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
    int? country,
    String? city,
    String? address,
    dynamic postalCode,
    dynamic isOtpVerified,
    String? fatherName,
    String? cnic,
    String? gender,
    String? religion,
    String? dob,
    int? occupation,
    String? onlineStatus,
    int? adminUser,
    dynamic fbId,
    dynamic googleId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phone = phone;
    _imagePath = imagePath;
    _country = country;
    _city = city;
    _address = address;
    _postalCode = postalCode;
    _isOtpVerified = isOtpVerified;
    _fatherName = fatherName;
    _cnic = cnic;
    _gender = gender;
    _religion = religion;
    _dob = dob;
    _occupation = occupation;
    _onlineStatus = onlineStatus;
    _adminUser = adminUser;
    _fbId = fbId;
    _googleId = googleId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Mentor.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _phone = json['phone'];
    _imagePath = json['image_path'];
    _country = json['country'];
    _city = json['city'];
    _address = json['address'];
    _postalCode = json['postal_code'];
    _isOtpVerified = json['is_otp_verified'];
    _fatherName = json['father_name'];
    _cnic = json['cnic'];
    _gender = json['gender'];
    _religion = json['religion'];
    _dob = json['dob'];
    _occupation = json['occupation'];
    _onlineStatus = json['online_status'];
    _adminUser = json['admin_user'];
    _fbId = json['fb_id'];
    _googleId = json['google_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _imagePath;
  int? _country;
  String? _city;
  String? _address;
  dynamic _postalCode;
  dynamic _isOtpVerified;
  String? _fatherName;
  String? _cnic;
  String? _gender;
  String? _religion;
  String? _dob;
  int? _occupation;
  String? _onlineStatus;
  int? _adminUser;
  dynamic _fbId;
  dynamic _googleId;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phone => _phone;
  String? get imagePath => _imagePath;
  int? get country => _country;
  String? get city => _city;
  String? get address => _address;
  dynamic get postalCode => _postalCode;
  dynamic get isOtpVerified => _isOtpVerified;
  String? get fatherName => _fatherName;
  String? get cnic => _cnic;
  String? get gender => _gender;
  String? get religion => _religion;
  String? get dob => _dob;
  int? get occupation => _occupation;
  String? get onlineStatus => _onlineStatus;
  int? get adminUser => _adminUser;
  dynamic get fbId => _fbId;
  dynamic get googleId => _googleId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image_path'] = _imagePath;
    map['country'] = _country;
    map['city'] = _city;
    map['address'] = _address;
    map['postal_code'] = _postalCode;
    map['is_otp_verified'] = _isOtpVerified;
    map['father_name'] = _fatherName;
    map['cnic'] = _cnic;
    map['gender'] = _gender;
    map['religion'] = _religion;
    map['dob'] = _dob;
    map['occupation'] = _occupation;
    map['online_status'] = _onlineStatus;
    map['admin_user'] = _adminUser;
    map['fb_id'] = _fbId;
    map['google_id'] = _googleId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
