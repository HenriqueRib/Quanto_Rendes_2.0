class ResponseFunction {
  bool? success;
  String? message;

  ResponseFunction({this.success, this.message});

  ResponseFunction.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
