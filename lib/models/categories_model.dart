class CategoryModel {
  int? id;
  String? cNameAr;
  String? cNameEn;
  String? cImage;

  CategoryModel({this.id, this.cNameAr, this.cNameEn, this.cImage});

  factory CategoryModel.fromJson(Map json) => CategoryModel(
      id: json["cc_id"],
      cNameAr: json["cc_name_ar"],
      cNameEn: json["cc_name"],
      cImage: json["cc_image"]);
}
