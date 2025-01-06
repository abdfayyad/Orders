import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart'as http;
import 'package:programing_languages/Client/Stores/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';
class StoresClientCubit extends Cubit<StoresClientStatus>{
  StoresClientCubit():super(StoresInitialized());
late StoresModel storesModel;
  Future<StoresModel?> getStores() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}', // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http.get(
        Uri.parse('$BASE_URL/api/stores'),headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      storesModel= StoresModel.fromJson(parsedJson);

      emit(StoresSuccess(storesModel!));
    }else {
      print("certificate field");
      emit(StoresError());
      throw Exception('Failed to load profile data');
    }
  }
}