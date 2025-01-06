import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Admin/Profile/bloc/status.dart';

class ProfileAdminCubit extends Cubit<ProfileAdminStatus>{
ProfileAdminCubit():super(ProfileAdminInitializeStatus());

}