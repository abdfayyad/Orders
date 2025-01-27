import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Login/bloc/status.dart';
import 'package:http/http.dart'as http;

import '../../utils/end_point.dart';

// Define the possible states

class LoginCubit extends Cubit<LoginScreenStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  Future<void> loginUser(String email, String password) async {
    // Set loading state
  emit(LoginLoadingState());

    try {
      // Make HTTP request to your login API
      final response = await http.post(
        Uri.parse('$BASE_URL/api/login'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        //print(responseData);
        print("success");
        loginModel=LoginModel.fromJson(responseData);
        emit(LoginSuccessState(loginModel));
        print("------------------------------------");
      } else {
        // Unsuccessful login
        print("faild");
        final Map<String, dynamic> responseData = json.decode(response.body);
        final errorMessage = responseData['message'] as String;
        emit(LoginErrorState());
      }
    } catch (e) {
      // Error occurred
      emit(LoginErrorState());
    }
  }
  IconData suffix=Icons.visibility;
  bool isPasswordShow=true;
  void changePasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix= isPasswordShow?
    Icons.visibility:Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}
