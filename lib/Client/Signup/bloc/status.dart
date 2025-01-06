abstract class SignInScreenStates{}

class SignInInitialState extends SignInScreenStates{}
class SignInLoadingState extends SignInScreenStates{}
class SignInSuccessState extends SignInScreenStates
{
  SignInModel signInModel;
  SignInSuccessState(this.signInModel);
}
class SignInErrorState extends SignInScreenStates{

}
class SignInChangePasswordVisibilityState extends SignInScreenStates{}

class SignInModel {
  String? role;
  String? token;

  SignInModel({this.role, this.token});

  SignInModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    data['Token'] = this.token;
    return data;
  }
}