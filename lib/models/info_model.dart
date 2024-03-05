import 'dart:convert';

InfoModel infoFromJson(String str) => InfoModel.fromJson(json.decode(str));

String infoToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel {
  String name;
  String email;
  String mobile;
  String address;
  String image;

  InfoModel({
    this.name = "",
    this.email = "",
    this.mobile = "",
    this.address = "",
    this.image = "",
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    name: json["name"],
    email: json["emial"],
    mobile: json["mobile"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "emial": email,
    "mobile": mobile,
    "address": address,
    "image": image,
  };
}
