

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Admin/App_drawer/app_dawer.dart';
import 'package:programing_languages/Client/App_drawer/app_dawer.dart';
import 'package:programing_languages/Client/Signup/bloc/cubit.dart';
import 'package:programing_languages/Client/Signup/bloc/status.dart';
import 'package:programing_languages/Login/login.dart';


import '../../utils/shared_prefirance.dart';



class SignUpScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  SignInModel? signInModel;
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailAddressController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String selectedRole = "0"; // Default to Client role (0)

    return BlocProvider(
      create: (BuildContext context) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInScreenStates>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            signInModel = state.signInModel;
            SharedPref.saveData(key: 'token', value: state.signInModel.token)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            SharedPref.saveData(key: 'role', value: state.signInModel.role)
                .then((value) {
              print(SharedPref.getData(key: 'token'));
            });
            if (state.signInModel.role == '1') {
              Flushbar(
                  titleText: Text("hello admin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
                  messageText: Text("welcome in our application", style: TextStyle(fontSize: 16.0, color: Colors.green),),
                  duration:  Duration(seconds: 3),
                  margin: EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(8)
              ).show(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerAdmin()), (Route<dynamic> route) => false);

            }
            else if (state.signInModel.role == '0') {
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
          if (state is SignInErrorState) {
            Flushbar(
              titleText: Text(
                "Error Signing In",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.deepPurple,
                  fontFamily: "ShadowsIntoLightTwo",
                ),
              ),
              messageText: Text(
                "Your email is already taken.",
                style: TextStyle(fontSize: 16.0, color: Colors.deepPurple),
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              margin: EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
            ).show(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('SignUp'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter User Name Please';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter User Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
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
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Enter Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          obscureText: SignInCubit.get(context).isPasswordShow,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SignInCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(SignInCubit.get(context).suffix),
                            ),
                            hintText: 'Enter Your Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text("Client"),
                                value: "0",
                                groupValue: selectedRole,
                                onChanged: (value) {
                                  selectedRole = value!;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<String>(
                                title: Text("Admin"),
                                value: "1",
                                groupValue: selectedRole,
                                onChanged: (value) {
                                  selectedRole = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SignInCubit.get(context).loginUser(
                                userNameController.text,
                                emailAddressController.text,
                                passwordController.text,
                                selectedRole, // Pass the selected role
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            height: 40.0,
                            width: 100.0,
                            child: Center(
                              child: Text('SIGN_UP',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
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
    );
  }
}
