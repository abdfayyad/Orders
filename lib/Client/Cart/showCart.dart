import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart'as http;
import 'package:programing_languages/Client/App_drawer/app_dawer.dart';
import 'package:programing_languages/Client/Cart/bloc/cubit.dart';
import 'package:programing_languages/Client/Cart/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';

class ShowCart extends StatelessWidget {
   ShowCart({super.key});
  ShowCartModel ?showCartModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowCartCubit()..getCart(),
      child: BlocConsumer<ShowCartCubit,ShowCartStatus>(
        listener: (context,state){
          if(state is ShowCartSuccessStatus)
            showCartModel=state.showCartModel;
        },
        builder: (context,state){
          return Scaffold(
            floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    addToCart(context);
                    // Add your onPressed code here!
                  },
                  backgroundColor: Colors.deepOrange,
                  label: const Text('Pay',style: TextStyle(color: Colors.white),),
                  icon: const Icon(Icons.shopping_cart,color: Colors.white),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child:5==5? GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio:
                  2 / 2.3, // Aspect ratio for each item
                ),
                itemCount: 5, // Total number of items
                itemBuilder:
                    (BuildContext context, int index) {
                  return InkWell(
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
                            child: Image.asset(
                              'assets/image/b.png',
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
                              'productName}',
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
                                  '\$productPrice}.00',
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
Future<void> addToCart(BuildContext context) async {
  final String url = '$BASE_URL/api/client/cart/buy_items';
  print(url);
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',  // If authentication is required
      },
    );
    if (response.statusCode == 200) {
      // Successful response
      print(response.body);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerClient()), (Route<dynamic> route) => false);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product deliverd  successfully!')));
      print('Order assigned to delivery successfully.');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add Product !')));
      print(response.body);
      // Error response
      print('Failed ,Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle any exceptions
    print('Exception occurred: $e');
  }
}