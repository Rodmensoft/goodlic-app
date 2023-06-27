class AboutUsModel {
  AboutUsModel({
      bool? status, 
      num? success, 
      Data? data, 
      String? msg,}){
    _status = status;
    _success = success;
    _data = data;
    _msg = msg;
}

  AboutUsModel.fromJson(dynamic json) {
    _status = json['Status'];
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _msg = json['msg'];
  }
  bool? _status;
  num? _success;
  Data? _data;
  String? _msg;
AboutUsModel copyWith({  bool? status,
  num? success,
  Data? data,
  String? msg,
}) => AboutUsModel(  status: status ?? _status,
  success: success ?? _success,
  data: data ?? _data,
  msg: msg ?? _msg,
);
  bool? get status => _status;
  num? get success => _success;
  Data? get data => _data;
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

class Data {
  Data({
      AboutUsContent? aboutUsContent,}){
    _aboutUsContent = aboutUsContent;
}

  Data.fromJson(dynamic json) {
    _aboutUsContent = json['about_us_content'] != null ? AboutUsContent.fromJson(json['about_us_content']) : null;
  }
  AboutUsContent? _aboutUsContent;
Data copyWith({  AboutUsContent? aboutUsContent,
}) => Data(  aboutUsContent: aboutUsContent ?? _aboutUsContent,
);
  AboutUsContent? get aboutUsContent => _aboutUsContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_aboutUsContent != null) {
      map['about_us_content'] = _aboutUsContent?.toJson();
    }
    return map;
  }

}

class AboutUsContent {
  AboutUsContent({
      num? id, 
      String? section1Title, 
      String? section1Description, 
      String? section1Image, 
      String? section2Title, 
      String? section2Description, 
      String? section2FirstImage, 
      String? section2FirstHeading, 
      String? section2FirstSubHeading, 
      String? section2SecondImage, 
      String? section2SecondHeading, 
      String? section2SecondSubHeading, 
      String? section2ThirdImage, 
      String? section2ThirdHeading, 
      String? section2ThirdSubHeading, 
      String? section3Title, 
      String? section3Description, 
      String? section3Image,}){
    _id = id;
    _section1Title = section1Title;
    _section1Description = section1Description;
    _section1Image = section1Image;
    _section2Title = section2Title;
    _section2Description = section2Description;
    _section2FirstImage = section2FirstImage;
    _section2FirstHeading = section2FirstHeading;
    _section2FirstSubHeading = section2FirstSubHeading;
    _section2SecondImage = section2SecondImage;
    _section2SecondHeading = section2SecondHeading;
    _section2SecondSubHeading = section2SecondSubHeading;
    _section2ThirdImage = section2ThirdImage;
    _section2ThirdHeading = section2ThirdHeading;
    _section2ThirdSubHeading = section2ThirdSubHeading;
    _section3Title = section3Title;
    _section3Description = section3Description;
    _section3Image = section3Image;
}

  AboutUsContent.fromJson(dynamic json) {
    _id = json['id'];
    _section1Title = json['section_1_title'];
    _section1Description = json['section_1_description'];
    _section1Image = json['section_1_image'];
    _section2Title = json['section_2_title'];
    _section2Description = json['section_2_description'];
    _section2FirstImage = json['section_2_first_image'];
    _section2FirstHeading = json['section_2_first_heading'];
    _section2FirstSubHeading = json['section_2_first_sub_heading'];
    _section2SecondImage = json['section_2_second_image'];
    _section2SecondHeading = json['section_2_second_heading'];
    _section2SecondSubHeading = json['section_2_second_sub_heading'];
    _section2ThirdImage = json['section_2_third_image'];
    _section2ThirdHeading = json['section_2_third_heading'];
    _section2ThirdSubHeading = json['section_2_third_sub_heading'];
    _section3Title = json['section_3_title'];
    _section3Description = json['section_3_description'];
    _section3Image = json['section_3_image'];
  }
  num? _id;
  String? _section1Title;
  String? _section1Description;
  String? _section1Image;
  String? _section2Title;
  String? _section2Description;
  String? _section2FirstImage;
  String? _section2FirstHeading;
  String? _section2FirstSubHeading;
  String? _section2SecondImage;
  String? _section2SecondHeading;
  String? _section2SecondSubHeading;
  String? _section2ThirdImage;
  String? _section2ThirdHeading;
  String? _section2ThirdSubHeading;
  String? _section3Title;
  String? _section3Description;
  String? _section3Image;
AboutUsContent copyWith({  num? id,
  String? section1Title,
  String? section1Description,
  String? section1Image,
  String? section2Title,
  String? section2Description,
  String? section2FirstImage,
  String? section2FirstHeading,
  String? section2FirstSubHeading,
  String? section2SecondImage,
  String? section2SecondHeading,
  String? section2SecondSubHeading,
  String? section2ThirdImage,
  String? section2ThirdHeading,
  String? section2ThirdSubHeading,
  String? section3Title,
  String? section3Description,
  String? section3Image,
}) => AboutUsContent(  id: id ?? _id,
  section1Title: section1Title ?? _section1Title,
  section1Description: section1Description ?? _section1Description,
  section1Image: section1Image ?? _section1Image,
  section2Title: section2Title ?? _section2Title,
  section2Description: section2Description ?? _section2Description,
  section2FirstImage: section2FirstImage ?? _section2FirstImage,
  section2FirstHeading: section2FirstHeading ?? _section2FirstHeading,
  section2FirstSubHeading: section2FirstSubHeading ?? _section2FirstSubHeading,
  section2SecondImage: section2SecondImage ?? _section2SecondImage,
  section2SecondHeading: section2SecondHeading ?? _section2SecondHeading,
  section2SecondSubHeading: section2SecondSubHeading ?? _section2SecondSubHeading,
  section2ThirdImage: section2ThirdImage ?? _section2ThirdImage,
  section2ThirdHeading: section2ThirdHeading ?? _section2ThirdHeading,
  section2ThirdSubHeading: section2ThirdSubHeading ?? _section2ThirdSubHeading,
  section3Title: section3Title ?? _section3Title,
  section3Description: section3Description ?? _section3Description,
  section3Image: section3Image ?? _section3Image,
);
  num? get id => _id;
  String? get section1Title => _section1Title;
  String? get section1Description => _section1Description;
  String? get section1Image => _section1Image;
  String? get section2Title => _section2Title;
  String? get section2Description => _section2Description;
  String? get section2FirstImage => _section2FirstImage;
  String? get section2FirstHeading => _section2FirstHeading;
  String? get section2FirstSubHeading => _section2FirstSubHeading;
  String? get section2SecondImage => _section2SecondImage;
  String? get section2SecondHeading => _section2SecondHeading;
  String? get section2SecondSubHeading => _section2SecondSubHeading;
  String? get section2ThirdImage => _section2ThirdImage;
  String? get section2ThirdHeading => _section2ThirdHeading;
  String? get section2ThirdSubHeading => _section2ThirdSubHeading;
  String? get section3Title => _section3Title;
  String? get section3Description => _section3Description;
  String? get section3Image => _section3Image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['section_1_title'] = _section1Title;
    map['section_1_description'] = _section1Description;
    map['section_1_image'] = _section1Image;
    map['section_2_title'] = _section2Title;
    map['section_2_description'] = _section2Description;
    map['section_2_first_image'] = _section2FirstImage;
    map['section_2_first_heading'] = _section2FirstHeading;
    map['section_2_first_sub_heading'] = _section2FirstSubHeading;
    map['section_2_second_image'] = _section2SecondImage;
    map['section_2_second_heading'] = _section2SecondHeading;
    map['section_2_second_sub_heading'] = _section2SecondSubHeading;
    map['section_2_third_image'] = _section2ThirdImage;
    map['section_2_third_heading'] = _section2ThirdHeading;
    map['section_2_third_sub_heading'] = _section2ThirdSubHeading;
    map['section_3_title'] = _section3Title;
    map['section_3_description'] = _section3Description;
    map['section_3_image'] = _section3Image;
    return map;
  }

}