class ActivateDeactivateUserModel {
  final int? status;
  final String? message;

  ActivateDeactivateUserModel({this.status, this.message});

  factory ActivateDeactivateUserModel.fromJson(Map<String, dynamic> json) =>
      ActivateDeactivateUserModel(
          status: json["status"], message: json["message"]);
}
