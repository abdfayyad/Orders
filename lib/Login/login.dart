
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Admin/App_drawer/app_dawer.dart';
import 'package:programing_languages/Client/App_drawer/app_dawer.dart';
import 'package:programing_languages/Client/Signup/siginup.dart';
import 'package:programing_languages/Login/bloc/cubit.dart';
import 'package:programing_languages/Login/bloc/status.dart';

import '../utils/shared_prefirance.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: BlocConsumer<LoginCubit, LoginScreenStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              SharedPref.saveData(key: 'token', value: state.loginModel.token)
                  .then((value) {
                print(SharedPref.getData(key: 'token'));
              });
              SharedPref.saveData(key: 'role', value: state.loginModel.role)
                  .then((value) {
                print(SharedPref.getData(key: 'role'));
              });
              if (state.loginModel.role == 1) {
                Flushbar(
                    titleText: Text("hello admin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                    messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                    duration:  Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8)
                ).show(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerAdmin()), (Route<dynamic> route) => false);

              }
              else if (state.loginModel.role == 0) {
                Flushbar(
                    titleText: Text("Hello client", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                    messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                    duration:  Duration(seconds: 3),
                    margin: EdgeInsets.all(8),
                    borderRadius: BorderRadius.circular(8)
                ).show(context);

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerClient()), (Route<dynamic> route) => false);
              }
            }
            if(state is LoginErrorState){
              Flushbar(
                  titleText: Text("error login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepPurple, fontFamily:"ShadowsIntoLightTwo"),),
                  messageText: Text("error in your email or password", style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),),
                  duration:  Duration(seconds: 3),
                  backgroundColor: Colors.red,
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)

              ).show(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [


                          TextFormField(
                              controller: emailAddressController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Your Email Please';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  hintText: 'Enter Email Address',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(30.0)))),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },

                            obscureText: LoginCubit.get(context)
                                .isPasswordShow, //isPasswordShow,
                            decoration: InputDecoration(
                                labelText: 'password',
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                  icon: Icon(LoginCubit.get(context).suffix),
                                ),
                                hintText: 'Enter Your Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),

                          MaterialButton(
                            onPressed: () {
                              LoginCubit.get(context).loginUser(
                                  emailAddressController.text, passwordController.text);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                              ),
                              height: 40.0,
                              width: 100.0,
                              child: Center(
                                  child: Text('Login', style: TextStyle())),
                            ),


                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Alreadyhaveanaccount'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'sign up',
                                      style: TextStyle(color: Colors.blue),
                                    ))
                              ]),
                          const SizedBox(
                            height: 30,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
