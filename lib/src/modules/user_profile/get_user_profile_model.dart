

import 'package:consultant_product/src/modules/consultant/create_profile/model_post_education_info.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/model_post_experience_info.dart';

class GetUserProfileModel {
  GetUserProfileModel({
      bool? status, 
      int? success,
    GetUserProfileModelData? data,
      String? msg,}){
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
}

  GetUserProfileModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? GetUserProfileModelData.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  int? _success;
  GetUserProfileModelData? _data;
  String? _msg;

  bool? get status => _status;
  int? get success => _success;
  GetUserProfileModelData? get data => _data;
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

class GetUserProfileModelData {
  GetUserProfileModelData({
      String? accessToken,
    UserDetailFromGetProfile? userDetail,}){
    _accessToken = accessToken;
    _userDetail = userDetail;
}

  GetUserProfileModelData.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _userDetail = json['userDetail'] != null ? UserDetailFromGetProfile.fromJson(json['userDetail']) : null;
  }
  String? _accessToken;
  UserDetailFromGetProfile? _userDetail;

  String? get accessToken => _accessToken;
  UserDetailFromGetProfile? get userDetail => _userDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    if (_userDetail != null) {
      map['userDetail'] = _userDetail?.toJson();
    }
    return map;
  }

}

class UserDetailFromGetProfile {
  UserDetailFromGetProfile({
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
      String? createdAt,
      String? updatedAt,
    MentorFromGetProfile? mentor,
      List<Education>? educations,
      List<Experience>? experiences,
    CardDetailFromGetProfile? cardDetail,}){
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
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _mentor = mentor;
    _educations = educations;
    _experiences = experiences;
    _cardDetail = cardDetail;
}

  UserDetailFromGetProfile.fromJson(dynamic json) {
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
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _mentor = json['mentor'] != null ? MentorFromGetProfile.fromJson(json['mentor']) : null;
    if (json['educations'] != null) {
      _educations = [];
      json['educations'].forEach((v) {
        _educations?.add(Education.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      _experiences = [];
      json['experiences'].forEach((v) {
        _experiences?.add(Experience.fromJson(v));
      });
    }
    _cardDetail = json['card_detail'] != null ? CardDetailFromGetProfile.fromJson(json['card_detail']) : null;
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
  String? _createdAt;
  String? _updatedAt;
  MentorFromGetProfile? _mentor;
  List<Education>? _educations;
  List<Experience>? _experiences;
  CardDetailFromGetProfile? _cardDetail;

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
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  MentorFromGetProfile? get mentor => _mentor;
  List<Education>? get educations => _educations;
  List<Experience>? get experiences => _experiences;
  CardDetailFromGetProfile? get cardDetail => _cardDetail;

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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_mentor != null) {
      map['mentor'] = _mentor?.toJson();
    }
    if (_educations != null) {
      map['educations'] = _educations?.map((v) => v.toJson()).toList();
    }
    if (_experiences != null) {
      map['experiences'] = _experiences?.map((v) => v.toJson()).toList();
    }
    if (_cardDetail != null) {
      map['card_detail'] = _cardDetail?.toJson();
    }
    return map;
  }

}

class CardDetailFromGetProfile {
  CardDetailFromGetProfile({
      int? id, 
      String? accountTitle, 
      String? accountNumber, 
      String? bank, 
      int? mentorId,}){
    _id = id;
    _accountTitle = accountTitle;
    _accountNumber = accountNumber;
    _bank = bank;
    _mentorId = mentorId;
}

  CardDetailFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _accountTitle = json['account_title'];
    _accountNumber = json['account_number'];
    _bank = json['bank'];
    _mentorId = json['mentor_id'];
  }
  int? _id;
  String? _accountTitle;
  String? _accountNumber;
  String? _bank;
  int? _mentorId;

  int? get id => _id;
  String? get accountTitle => _accountTitle;
  String? get accountNumber => _accountNumber;
  String? get bank => _bank;
  int? get mentorId => _mentorId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_title'] = _accountTitle;
    map['account_number'] = _accountNumber;
    map['bank'] = _bank;
    map['mentor_id'] = _mentorId;
    return map;
  }

}

// class ExperiencesFromGetProfile {
//   ExperiencesFromGetProfile({
//       int? id,
//       int? mentorId,
//       String? company,
//       String? from,
//       String? to,
//       String? imagePath,
//       String? createdAt,
//       String? updatedAt,}){
//     _id = id;
//     _mentorId = mentorId;
//     _company = company;
//     _from = from;
//     _to = to;
//     _imagePath = imagePath;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   ExperiencesFromGetProfile.fromJson(dynamic json) {
//     _id = json['id'];
//     _mentorId = json['mentor_id'];
//     _company = json['company'];
//     _from = json['from'];
//     _to = json['to'];
//     _imagePath = json['image_path'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   int? _mentorId;
//   String? _company;
//   String? _from;
//   String? _to;
//   String? _imagePath;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   int? get mentorId => _mentorId;
//   String? get company => _company;
//   String? get from => _from;
//   String? get to => _to;
//   String? get imagePath => _imagePath;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['mentor_id'] = _mentorId;
//     map['company'] = _company;
//     map['from'] = _from;
//     map['to'] = _to;
//     map['image_path'] = _imagePath;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }

// class EducationsFromGetProfile {
//   EducationsFromGetProfile({
//       int? id,
//       int? mentorId,
//       String? institute,
//       String? degree,
//       String? subject,
//       String? period,
//       String? imagePath,
//       String? createdAt,
//       String? updatedAt,}){
//     _id = id;
//     _mentorId = mentorId;
//     _institute = institute;
//     _degree = degree;
//     _subject = subject;
//     _period = period;
//     _imagePath = imagePath;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   EducationsFromGetProfile.fromJson(dynamic json) {
//     _id = json['id'];
//     _mentorId = json['mentor_id'];
//     _institute = json['institute'];
//     _degree = json['degree'];
//     _subject = json['subject'];
//     _period = json['period'];
//     _imagePath = json['image_path'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   int? _mentorId;
//   String? _institute;
//   String? _degree;
//   String? _subject;
//   String? _period;
//   String? _imagePath;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   int? get mentorId => _mentorId;
//   String? get institute => _institute;
//   String? get degree => _degree;
//   String? get subject => _subject;
//   String? get period => _period;
//   String? get imagePath => _imagePath;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['mentor_id'] = _mentorId;
//     map['institute'] = _institute;
//     map['degree'] = _degree;
//     map['subject'] = _subject;
//     map['period'] = _period;
//     map['image_path'] = _imagePath;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }

class MentorFromGetProfile {
  MentorFromGetProfile({
      int? id, 
      int? userId, 
      int? mentorCategoryId, 
      int? parentCategoryId, 
      dynamic description, 
      dynamic paymentType, 
      int? status, 
      int? isProfileCompleted, 
      int? isLive,
      dynamic isVerified,
      int? fee, 
      String? createdAt, 
      String? updatedAt,
    // List<CategoryListFromGetProfile>? category,
    CategoryFromGetProfile? category,
    // CategoryFromGetProfile? parentCategory,
  }){
    _id = id;
    _userId = userId;
    _mentorCategoryId = mentorCategoryId;
    _parentCategoryId = parentCategoryId;
    _description = description;
    _paymentType = paymentType;
    _status = status;
    _isProfileCompleted = isProfileCompleted;
    _isLive = isLive;
    _isVerified = isVerified;
    _fee = fee;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
    // _parentCategory = parentCategory;
}

  MentorFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _mentorCategoryId = json['mentor_category_id'];
    _parentCategoryId = json['parent_category_id'];
    _description = json['description'];
    _paymentType = json['payment_type'];
    _status = json['status'];
    _isProfileCompleted = json['is_profile_completed'];
    _isLive = json['is_live'];
    _isVerified = json['is_verified'];
    _fee = json['fee'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    // if (json['categories'] != null) {
    //   _category = [];
    //   json['categories'].forEach((v) {
    //     _category?.add(CategoryListFromGetProfile.fromJson(v));
    //   });
    // }
    _category = json['categories'] != null ? CategoryFromGetProfile.fromJson(json['categories']) : null;
    // _category = json['category'] != null ? CategoryListFromGetProfile.fromJson(json['category']) : null;
    // _parentCategory = json['parent_category'] != null ? CategoryFromGetProfile.fromJson(json['parent_category']) : null;
  }
  int? _id;
  int? _userId;
  int? _mentorCategoryId;
  int? _parentCategoryId;
  dynamic _description;
  dynamic _paymentType;
  int? _status;
  int? _isProfileCompleted;
  int? _isLive;
  dynamic _isVerified;
  int? _fee;
  String? _createdAt;
  String? _updatedAt;
  // List<CategoryListFromGetProfile>? _category;
  CategoryFromGetProfile? _category;
  // CategoryFromGetProfile? _parentCategory;

  int? get id => _id;
  int? get userId => _userId;
  int? get mentorCategoryId => _mentorCategoryId;
  int? get parentCategoryId => _parentCategoryId;
  dynamic get description => _description;
  dynamic get paymentType => _paymentType;
  int? get status => _status;
  int? get isProfileCompleted => _isProfileCompleted;
  int? get isLive => _isLive;
  dynamic get isVerified => _isVerified;
  int? get fee => _fee;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  // List<CategoryListFromGetProfile>? get category => _category;
  CategoryFromGetProfile? get category => _category;
  // CategoryFromGetProfile? get parentCategory => _parentCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['mentor_category_id'] = _mentorCategoryId;
    map['parent_category_id'] = _parentCategoryId;
    map['description'] = _description;
    map['payment_type'] = _paymentType;
    map['status'] = _status;
    map['is_profile_completed'] = _isProfileCompleted;
    map['is_live'] = _isLive;
    map['is_verified'] = _isVerified;
    map['fee'] = _fee;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    // if (_category != null) {
    //   map['categories'] = _category?.map((v) => v.toJson()).toList();
    // }
    if (_category != null) {
      map['categories'] = _category?.toJson();
    }
    // if (_parentCategory != null) {
    //   map['parent_category'] = _parentCategory?.toJson();
    // }
    return map;
  }

}
class CategoryListFromGetProfile {
  CategoryListFromGetProfile({
    int? id,
    int? mentorId,
    int? categoryId,
    CategoryFromGetProfile? category,}){
    _id = id;
    _mentorId = mentorId;
    _categoryId = categoryId;
    _category = category;
  }

  CategoryListFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _mentorId = json['mentor_id'];
    _categoryId = json['category_id'];
    _category = json['category'] != null ? CategoryFromGetProfile.fromJson(json['category']) : null;
  }
  int? _id;
  int? _mentorId;
  int? _categoryId;
  CategoryFromGetProfile? _category;

  int? get id => _id;
  int? get mentorId => _mentorId;
  int? get categoryId => _categoryId;
  CategoryFromGetProfile? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mentor_id'] = _mentorId;
    map['category_id'] = _categoryId;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }

}
class CategoryFromGetProfile {
  CategoryFromGetProfile({
    int? id,
    int? parentId,
    String? name,
    String? slug,
    String? imagePath,
    dynamic description,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _parentId = parentId;
    _name = name;
    _slug = slug;
    _imagePath = imagePath;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  CategoryFromGetProfile.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _slug = json['slug'];
    _imagePath = json['image_path'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  int? _parentId;
  String? _name;
  String? _slug;
  String? _imagePath;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get name => _name;
  String? get slug => _slug;
  String? get imagePath => _imagePath;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['name'] = _name;
    map['slug'] = _slug;
    map['image_path'] = _imagePath;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
// class CategoryFromGetProfile {
//   CategoryFromGetProfile({
//       int? id,
//       int? parentId,
//       String? name,
//       String? imagePath,
//       dynamic description,
//       String? createdAt,
//       String? updatedAt,}){
//     _id = id;
//     _parentId = parentId;
//     _name = name;
//     _imagePath = imagePath;
//     _description = description;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   CategoryFromGetProfile.fromJson(dynamic json) {
//     _id = json['id'];
//     _parentId = json['parent_id'];
//     _name = json['name'];
//     _imagePath = json['image_path'];
//     _description = json['description'];
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//   int? _id;
//   int? _parentId;
//   String? _name;
//   String? _imagePath;
//   dynamic _description;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   int? get parentId => _parentId;
//   String? get name => _name;
//   String? get imagePath => _imagePath;
//   dynamic get description => _description;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['parent_id'] = _parentId;
//     map['name'] = _name;
//     map['image_path'] = _imagePath;
//     map['description'] = _description;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }