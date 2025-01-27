abstract class LoginScreenStates{}

class LoginInitialState extends LoginScreenStates{}
class LoginLoadingState extends LoginScreenStates{}
class LoginSuccessState extends LoginScreenStates
{
LoginModel loginModel;

LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginScreenStates{


}
class LoginChangePasswordVisibilityState extends LoginScreenStates{}


class LoginModel {
  String? token;
  int? role;

  LoginModel({this.token, this.role});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.token;
    data['role'] = this.role;
    return data;
  }
}