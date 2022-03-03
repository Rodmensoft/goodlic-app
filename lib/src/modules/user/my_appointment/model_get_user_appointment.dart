class GetUserAppointmentModel {
  GetUserAppointmentModel({
      bool? status, 
      int? success,
    GetUserAppointmentModelData? data,
      String? msg,}){
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
}

  GetUserAppointmentModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? GetUserAppointmentModelData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetUserAppointmentModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetUserAppointmentModelData? get data => _data;
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

class GetUserAppointmentModelData {
  GetUserAppointmentModelData({
    AppointmentsPageData? pendingAppointments,
    AppointmentsPageData? acceptedAppointments,
    AppointmentsPageData? completedAppointments,
    AppointmentsPageData? cancelledAppointments,}){
    _pendingAppointments = pendingAppointments;
    _acceptedAppointments = acceptedAppointments;
    _completedAppointments = completedAppointments;
    _cancelledAppointments = cancelledAppointments;
}

  GetUserAppointmentModelData.fromJson(dynamic json) {
    _pendingAppointments = json['pendingAppointments'] != null ? AppointmentsPageData.fromJson(json['pendingAppointments']) : null;
    _acceptedAppointments = json['acceptedAppointments'] != null ? AppointmentsPageData.fromJson(json['acceptedAppointments']) : null;
    _completedAppointments = json['completedAppointments'] != null ? AppointmentsPageData.fromJson(json['completedAppointments']) : null;
    _cancelledAppointments = json['cancelledAppointments'] != null ? AppointmentsPageData.fromJson(json['cancelledAppointments']) : null;
  }
  AppointmentsPageData? _pendingAppointments;
  AppointmentsPageData? _acceptedAppointments;
  AppointmentsPageData? _completedAppointments;
  AppointmentsPageData? _cancelledAppointments;

  AppointmentsPageData? get pendingAppointments => _pendingAppointments;
  AppointmentsPageData? get acceptedAppointments => _acceptedAppointments;
  AppointmentsPageData? get completedAppointments => _completedAppointments;
  AppointmentsPageData? get cancelledAppointments => _cancelledAppointments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pendingAppointments != null) {
      map['pendingAppointments'] = _pendingAppointments?.toJson();
    }
    if (_acceptedAppointments != null) {
      map['acceptedAppointments'] = _acceptedAppointments?.toJson();
    }
    if (_completedAppointments != null) {
      map['completedAppointments'] = _completedAppointments?.toJson();
    }
    if (_cancelledAppointments != null) {
      map['cancelledAppointments'] = _cancelledAppointments?.toJson();
    }
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class AppointmentsPageData {
  AppointmentsPageData({
      int? currentPage, 
      List<UserAppointmentsData>? data,
      String? firstPageUrl, 
      dynamic from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      dynamic nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      dynamic to, 
      int? total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  AppointmentsPageData.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserAppointmentsData.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int? _currentPage;
  List<UserAppointmentsData>? _data;
  String? _firstPageUrl;
  dynamic _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  dynamic _to;
  int? _total;

  int? get currentPage => _currentPage;
  List<UserAppointmentsData>? get data => _data;
  String? get firstPageUrl => _firstPageUrl;
  dynamic get from => _from;
  int? get lastPage => _lastPage;
  String? get lastPageUrl => _lastPageUrl;
  List<Links>? get links => _links;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;
  int? get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  dynamic get to => _to;
  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class UserAppointmentsData {
  UserAppointmentsData({
      int? id, 
      int? menteeId, 
      int? mentorId, 
      String? date, 
      String? time, 
      int? payment, 
      int? isPaid, 
      dynamic paymentStatusCode, 
      dynamic paymentResponseMsg, 
      dynamic paymentOrderRef, 
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
    UserAppointmentsDataMentor? mentor,}){
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
    _mentor = mentor;
}

  UserAppointmentsData.fromJson(dynamic json) {
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
    _mentor = json['mentor'] != null ? UserAppointmentsDataMentor.fromJson(json['mentor']) : null;
  }
  int? _id;
  int? _menteeId;
  int? _mentorId;
  String? _date;
  String? _time;
  int? _payment;
  int? _isPaid;
  dynamic _paymentStatusCode;
  dynamic _paymentResponseMsg;
  dynamic _paymentOrderRef;
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
  UserAppointmentsDataMentor? _mentor;

  int? get id => _id;
  int? get menteeId => _menteeId;
  int? get mentorId => _mentorId;
  String? get date => _date;
  String? get time => _time;
  int? get payment => _payment;
  int? get isPaid => _isPaid;
  dynamic get paymentStatusCode => _paymentStatusCode;
  dynamic get paymentResponseMsg => _paymentResponseMsg;
  dynamic get paymentOrderRef => _paymentOrderRef;
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
  UserAppointmentsDataMentor? get mentor => _mentor;

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
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    return map;
  }

}

class UserAppointmentsDataMentor {
  UserAppointmentsDataMentor({
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
      String? updatedAt,}){
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

  UserAppointmentsDataMentor.fromJson(dynamic json) {
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