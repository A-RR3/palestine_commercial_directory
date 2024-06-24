


class CompanyModel {
  final int? cId;
  final int? cOwnerId;
  final String? cName;
  final String? cNameAR;
  final String? cPhone;
  final String? image;
  final double? latitude;
  final double? logitude;
  final String? ownerName;
  final String? ownerNameAr;

  CompanyModel(
      {this.cId,
      this.cOwnerId,
      this.cName,
      this.cNameAR,
      this.cPhone,
      this.image,
      this.latitude,
      this.logitude,
      this.ownerName,
      this.ownerNameAr});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
      cId: json["c_id"],
      cOwnerId: json["c_owner_id"],
      cName: json["c_name"],
      cNameAR: json["c_name_ar"],
      cPhone: json["c_phone"],
      image: json["c_image"],
      latitude: json["c_latitude"] != null
          ? double.parse(json["c_latitude"])
          : 31.546008,
      logitude: json['c_longitude'] != null
          ? double.parse(json["c_longitude"])
          : 35.092858,
      ownerName: json["user"]["u_name"],
      ownerNameAr: json["user"]["u_name_ar"]);
}
