abstract class ProfileClientStatus {}

class ProfileClientInitializeStatus extends ProfileClientStatus{}
class ProfileClientSuccessStatus extends ProfileClientStatus{
  ProfileModel profileModel;

  ProfileClientSuccessStatus(this.profileModel);
}
class ProfileClientErrorStatus extends ProfileClientStatus{}
class ProfileClientLoadingStatus extends ProfileClientStatus{}



class ProfileModel {
  String? name;
  String? email;
  String? phoneNumber;

  ProfileModel({this.name, this.email, this.phoneNumber});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}