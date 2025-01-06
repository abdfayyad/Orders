import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart'as http;
import 'package:programing_languages/Client/Stores/products/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';
class ProductsClientCubit extends Cubit<ProductsClientStatus>{
  ProductsClientCubit():super(ProductsInitialized());
  late ProductsModel productsModel;
  Future<ProductsModel?> getProducts(String id) async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/products/$id'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      productsModel= ProductsModel.fromJson(parsedJson);

      emit(ProductsSuccess(productsModel));
    }else {
      print("certificate field");
      emit(ProductsError());
      throw Exception('Failed to load profile data');
    }
  }
}