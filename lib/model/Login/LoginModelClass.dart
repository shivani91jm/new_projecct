class LoginModelClass {
  String? message;
  var userId;
  String? userNicename;
  String? userDisplayName;
  String? userEmail;
  var mobileNumber;
  String? profilePicture;
 // String? token;
  var first_name;
  var last_name;

  LoginModelClass(
      {this.message,
       required this.userId,
        this.userNicename,
        this.userDisplayName,
        this.userEmail,
        required this.mobileNumber,
        this.profilePicture,
    //    this.token,
        this.first_name,
        this.last_name
      });

  LoginModelClass.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    userNicename = json['user_nicename'];
    userDisplayName = json['user_display_name'];
    userEmail = json['user_email'];
    mobileNumber = json['mobile_number'];
    profilePicture = json['profile_picture'];
  //  token = json['token'];
    first_name=json['first_name'];
    last_name=json['last_name'];
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
   // data['token'] = this.token;
    data['first_name'] =this.first_name;
    data['last_name']= this.last_name;

    return data;
  }
}