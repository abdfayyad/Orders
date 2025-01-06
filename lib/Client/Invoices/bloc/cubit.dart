import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:programing_languages/Client/Invoices/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';

class ShowInvoicesCubit extends Cubit<ShowInvoicesStatus> {
  ShowInvoicesCubit() : super(ShowInvoicesInitializeStatus());
  late ShowInvoicesModel showInvoicesModel;

  Future<ShowInvoicesModel?> getInvoices() async {
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${SharedPref.getData(key: 'token')}',
      // Replace with your header key and value
    };
    print(SharedPref.getData(key: 'token'));
    final response = await http
        .get(Uri.parse('${BASE_URL}/api/client/purchases'), headers: headers);
    print(headers);
    if (response.statusCode == 200) {
      print("institute details success");
      print(response.body);
      final parsedJson = jsonDecode(response.body);
      print(response.body);
      showInvoicesModel = ShowInvoicesModel.fromJson(parsedJson);

      emit(ShowInvoicesSuccessStatus(showInvoicesModel));
    } else {
      print("certificate field");
      emit(ShowInvoicesErrorStatus());
      throw Exception('Failed to load profile data');
    }
  }
}
