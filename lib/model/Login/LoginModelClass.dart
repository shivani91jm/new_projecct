class LoginModelClass {
  String? message;
  String? username;
  String? email;
  String? mobileNumber;
  String? token;

  LoginModelClass({this.message, this.username, this.email, this.mobileNumber, this.token});

  LoginModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    username = json['username'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['token'] = this.token;
    return data;
  }
}