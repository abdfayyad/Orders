import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Client/App_drawer/bloc/cubit.dart';
import 'package:programing_languages/Client/Invoices/showInvoices.dart';
import 'package:programing_languages/Client/Profile/profile.dart';
import 'package:programing_languages/Client/Stores/StoresClient.dart';
import 'package:programing_languages/Login/login.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';


import '../Cart/showCart.dart';




class AppDrawerClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DrawerCubit>(
      create: (context) => DrawerCubit(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: Text(
            'Stor',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        drawer: DrawerWidget(), // This DrawerWidget now has access to DrawerCubit
        body: BlocBuilder<DrawerCubit, DrawerPage>(
          builder: (context, state) {
            if (state == DrawerPage.stores) {
              return StoresClient();
            } else if (state == DrawerPage.cart) {
              return ShowCart();
            }
            else if (state == DrawerPage.invoices) {
              return ShowInvoices();
            }
            else if (state == DrawerPage.profile) {
              return ProfileClient();
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<DrawerCubit, DrawerPage>(
        builder: (context, state) {
          return ListView(
            children: [
              const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.orangeAccent),
                accountName: Text(
                  "welcome in our application",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  "welcome 😍",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPicture: FlutterLogo(),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Stores'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.stores,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.stores);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('cart'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.cart,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.cart);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart_outlined),
                title: Text('invoices'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.invoices,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.invoices);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('profile'),
                selectedColor: Colors.deepOrange,
                selected: state == DrawerPage.profile,
                onTap: () {
                  context.read<DrawerCubit>().selectPage(DrawerPage.profile);
                  Navigator.of(context).pop();
                },
              ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                selectedColor: Colors.deepOrange,

                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              SharedPref.removeData(key: 'token');
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false);
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}


