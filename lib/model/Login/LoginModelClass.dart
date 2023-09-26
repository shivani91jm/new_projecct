class LoginModelClass {
  String? message;
  var userId;
  String? userNicename;
  String? userDisplayName;
  String? userEmail;
  var mobileNumber;
  String? profilePicture;
  String? token;

  LoginModelClass(
      {this.message,
       required this.userId,
        this.userNicename,
        this.userDisplayName,
        this.userEmail,
        required this.mobileNumber,
        this.profilePicture,
        this.token});

  LoginModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
    userEmail = json['user_email'];
    mobileNumber = json['mobile_number'];
    profilePicture = json['profile_picture'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['user_nicename'] = this.userNicename;
    data['user_display_name'] = this.userDisplayName;
    data['user_email'] = this.userEmail;
    data['mobile_number'] = this.mobileNumber;
    data['profile_picture'] = this.profilePicture;
    data['token'] = this.token;
    return data;
  }
}