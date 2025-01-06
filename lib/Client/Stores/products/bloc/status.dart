abstract class ProductsClientStatus {}
class ProductsInitialized extends ProductsClientStatus{}
class ProductsSuccess extends ProductsClientStatus{
  ProductsModel productsModel;

  ProductsSuccess(this.productsModel);
}
class ProductsError extends ProductsClientStatus{}
class ProductsLoading extends ProductsClientStatus{}




class ProductsModel {
  List<Products>? products;

  ProductsModel({this.products});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? price;
  int? quantity;
  String? detels;
  int? storeId;

  Products(
      {this.id,
        this.name,
        this.price,
        this.quantity,
        this.detels,
        this.storeId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    detels = json['detels'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['detels'] = this.detels;
    data['store_id'] = this.storeId;
    return data;
  }
}