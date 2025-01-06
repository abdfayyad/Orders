import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Admin/Profile/bloc/cubit.dart';
import 'package:programing_languages/Admin/Profile/bloc/status.dart';



class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ProfileAdminCubit(),
      child: BlocConsumer<ProfileAdminCubit,ProfileAdminStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold();
        },
      ),

    );

  }
}
