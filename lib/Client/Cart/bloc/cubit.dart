import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:programing_languages/Client/Cart/bloc/status.dart';

import '../../../utils/end_point.dart';
import '../../../utils/shared_prefirance.dart';

class ShowCartCubit extends Cubit<ShowCartStatus> {
  ShowCartCubit() : super(ShowCartInitializeStatus());
  late ShowCartModel showCartModel;

  Future<ShowCartModel?> getCart() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    final response = await http
        .get(Uri.parse('$BASE_URL/api/client/cart/items'), headers: headers);

    if (response.statusCode == 200) {
      print("success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showCartModel = ShowCartModel.fromJson(parsedJson);

      emit(ShowCartSuccessStatus(showCartModel));
    } else {
      print(response.body);

      print(" field");
      emit(ShowCartErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
