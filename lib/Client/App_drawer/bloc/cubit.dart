import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum DrawerPage { stores , cart , invoices , profile , deliveries }

class DrawerCubit extends Cubit<DrawerPage> {
  DrawerCubit() : super(DrawerPage.stores);

  void selectPage(DrawerPage page) {
    emit(page);
  }
}
