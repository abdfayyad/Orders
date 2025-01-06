import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:programing_languages/Client/Stores/products/DetailsProduct.dart';
import 'package:programing_languages/Client/Stores/products/bloc/cubit.dart';
import 'package:programing_languages/Client/Stores/products/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';

import '../bloc/status.dart';

class ProductsScreenClient extends StatelessWidget {
  ProductsScreenClient({super.key,required this.id});
 final String id;

  Future<void> addProductToCart(String productId, BuildContext context) async {
    final url = Uri.parse('$BASE_URL/api/client/carts/add-product/$productId');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
        },
      );

      if (response.statusCode == 200) {
        print('Product added to cart successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added to cart successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Failed to add product to cart: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
  ProductsModel ?productsModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(BuildContext context)=>ProductsClientCubit()..getProducts(id),
      child: BlocConsumer<ProductsClientCubit,ProductsClientStatus>(
        listener: (context,state){
          if(state is ProductsSuccess)
            productsModel=state.productsModel;
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Stor 1",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              elevation: 2,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child:productsModel?.products!=null? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 2 / 2.3, // Aspect ratio for each item
                ),
                itemCount:productsModel?.products?.length??0, // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsProduct(products: productsModel!.products![index],)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Image.asset(
                              'assets/image/b.png', // Replace with your image asset
                              height: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '${productsModel!.products![index].name}',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${productsModel!.products![index].price}',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      backgroundColor: Colors.deepPurple,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      // addProductToCart("${product.id}", context);
                                    },
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ):Center(child: CircularProgressIndicator(),),
            ),
          );
        },
      ),
    );
  }
}
