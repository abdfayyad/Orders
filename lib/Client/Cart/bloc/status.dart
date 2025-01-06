abstract class ShowCartStatus {}

class ShowCartInitializeStatus extends ShowCartStatus{}
class ShowCartSuccessStatus extends ShowCartStatus{
  ShowCartModel showCartModel;

  ShowCartSuccessStatus(this.showCartModel);
}
class ShowCartErrorStatus extends ShowCartStatus{}
class ShowCartLoadingStatus extends ShowCartStatus{}


class ShowCartModel {
  CartItems? cartItems;

  ShowCartModel({this.cartItems});

  ShowCartModel.fromJson(Map<String, dynamic> json) {
    cartItems = json['cart_items'] != null
        ? new CartItems.fromJson(json['cart_items'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.toJson();
    }
    return data;
  }
}

class CartItems {
  int? id;
  List<Products>? products;

  CartItems({this.id, this.products});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
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

