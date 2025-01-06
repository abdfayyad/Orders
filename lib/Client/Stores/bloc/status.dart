abstract class StoresClientStatus {}
class StoresInitialized extends StoresClientStatus{}
class StoresSuccess extends StoresClientStatus{
  StoresModel storesModel;

  StoresSuccess(this.storesModel);
}
class StoresError extends StoresClientStatus{}
class StoresLoading extends StoresClientStatus{}
class StoresModel {
  List<Stores>? stores;

  StoresModel({this.stores});

  StoresModel.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  int? id;
  String? name;
  String? location;

  Stores({this.id, this.name, this.location});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    return data;
  }
}