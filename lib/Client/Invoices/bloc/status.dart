abstract class ShowInvoicesStatus {}

class ShowInvoicesInitializeStatus extends ShowInvoicesStatus{}
class ShowInvoicesSuccessStatus extends ShowInvoicesStatus{
  ShowInvoicesModel showInvoicesModel;

  ShowInvoicesSuccessStatus(this.showInvoicesModel);
}
class ShowInvoicesErrorStatus extends ShowInvoicesStatus{}
class ShowInvoicesLoadingStatus extends ShowInvoicesStatus{}


class ShowInvoicesModel {
  List<Data>? data;

  ShowInvoicesModel({this.data});

  ShowInvoicesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? totalAmount;
  String? purchaseDate;
  ClientInfo? clientInfo;
  int? numberOfProducts;
  List<Products>? products;

  Data(
      {this.id,
        this.totalAmount,
        this.purchaseDate,
        this.clientInfo,
        this.numberOfProducts,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    purchaseDate = json['purchase_date'];
    clientInfo = json['client_info'] != null
        ? new ClientInfo.fromJson(json['client_info'])
        : null;
    numberOfProducts = json['number_of_products'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['purchase_date'] = this.purchaseDate;
    if (this.clientInfo != null) {
      data['client_info'] = this.clientInfo!.toJson();
    }
    data['number_of_products'] = this.numberOfProducts;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientInfo {
  int? id;
  Null? name;
  String? address;

  ClientInfo({this.id, this.name, this.address});

  ClientInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}

class Products {
  int? productId;
  String? productName;
  int? productPrice;
  String? productImage;
  String? productDescription;
  List<Colorss>? colors;

  Products(
      {this.productId,
        this.productName,
        this.productPrice,
        this.productImage,
        this.productDescription,
        this.colors});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productPrice = json['product_price'];
    productImage = json['product_image'];
    productDescription = json['product_description'];
    if (json['colors'] != null) {
      colors = <Colorss>[];
      json['colors'].forEach((v) {
        colors!.add(new Colorss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['product_image'] = this.productImage;
    data['product_description'] = this.productDescription;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colorss {
  int? colorId;
  String? colorName;

  Colorss({this.colorId, this.colorName});

  Colorss.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    colorName = json['color_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color_id'] = this.colorId;
    data['color_name'] = this.colorName;
    return data;
  }
}