import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:programing_languages/Admin/App_drawer/app_dawer.dart';
import 'package:programing_languages/Admin/Products/addProduct.dart';
import 'dart:convert';

import 'package:programing_languages/Admin/Products/bloc/cubit.dart';
import 'package:programing_languages/Admin/Products/bloc/status.dart';
import 'package:programing_languages/Admin/Products/showDetailsProduct.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';



class ShowProducts extends StatelessWidget {
   ShowProducts({super.key});
  final TextEditingController _searchController = TextEditingController();
ShowProductsAdminModel ?showProductsAdminModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowProductsAdminCubit()..getProducts(),
      child: BlocConsumer<ShowProductsAdminCubit,ShowProductsAdminStatus>(
        listener: (context,state){
          if(state is ShowProductsAdminSuccessStatus)
            showProductsAdminModel=state.showProductsAdminModel;
        },
        builder: (context,state){
          return showProductsAdminModel !=null
              ? Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing:
                        10.0, // Spacing between columns
                        mainAxisSpacing:
                        10.0, // Spacing between rows
                        childAspectRatio:
                        2 / 2.3, // Aspect ratio for each item
                      ),
                      itemCount: showProductsAdminModel?.data?.length, // Total number of items
                      itemBuilder:
                          (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen(data: showProductsAdminModel!.data![index],)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                    Radius.circular(15.0),
                                    topRight:
                                    Radius.circular(15.0),
                                  ),
                                  child: Image.network(
                                    '${showProductsAdminModel!.data![index].image}',
                                    // Replace with your image asset
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    '${showProductsAdminModel!.data![index].name}',
                                    style:const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        '\$${showProductsAdminModel!.data![index].price}.00',
                                        style:const TextStyle(
                                          color:
                                          Colors.deepOrange,
                                          fontSize: 16.0,
                                          fontWeight:
                                          FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            backgroundColor: Colors.deepOrange,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          onPressed: ()  {
                                            deleteProduct(context,"${showProductsAdminModel!.data![index].id}");
                                            } ,

                                          child: const Icon(
                                            Icons.delete,
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
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddProductScreen()));
              },
              backgroundColor: Colors.orange
            ),
          ):Center(child: CircularProgressIndicator(),);
        },
      ),

    );

  }
}

Future<void> deleteProduct(BuildContext context,String productId) async {
  final String url = '$BASE_URL/api/admin/products/$productId'; // Replace with your API endpoint

  try {
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // If your API requires authentication
      },
    );

    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerAdmin()), (Route<dynamic> route) => false);

      // If the server did delete the product successfully
      print(response.body);
    } else {
      print(response.body);

      // If the server did not delete the product successfully
      print('Failed to delete the product. Status code: ${response.statusCode}');

    }
  } catch (e) {
    print('Error occurred while deleting the product: $e');

  }
}
