import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Client/Invoices/bloc/cubit.dart';
import 'package:programing_languages/Client/Invoices/bloc/status.dart';
import 'package:programing_languages/Client/Invoices/detailsInvoices.dart';



class ShowInvoices extends StatelessWidget {
   ShowInvoices({super.key});
ShowInvoicesModel ?showInvoicesModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowInvoicesCubit()..getInvoices(),
      child: BlocConsumer<ShowInvoicesCubit, ShowInvoicesStatus>(
        listener: (context, state) {
          if(state is ShowInvoicesSuccessStatus)
            showInvoicesModel=state.showInvoicesModel;
        },
        builder: (context, state) {
          return Scaffold(
            body: 5==5
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Number of columns
                      crossAxisSpacing: 10.0, // Spacing between columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                      childAspectRatio: 8 / 2, // Aspect ratio for each item
                    ),
                    itemCount: 10, // Total number of items
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowDetailsInvoices()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(0.0),
                                ),
                                child: Image.asset(
                                  'assets/image/b.png',
                                  // Replace with your image asset
                                  width: 90,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'money amount :600',
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        'number of products:5 ',
                                        style: const TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Text(
                                        '5/5/2020',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
