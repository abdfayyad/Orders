import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Client/Invoices/bloc/cubit.dart';
import 'package:programing_languages/Client/Invoices/bloc/status.dart';



class ShowDetailsInvoices extends StatelessWidget {
   ShowDetailsInvoices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context)=>ShowInvoicesCubit(),
      child: BlocConsumer<ShowInvoicesCubit,ShowInvoicesStatus>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Invoice Details',style: TextStyle(color: Colors.deepOrange),),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          'money amount :600\$',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'number of products :5',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'date pay :5/5/2020',
                          style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0), // Adjust the radius as needed
                          ),
                        ),
                        width: double.infinity,
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              crossAxisSpacing:
                              10.0, // Spacing between columns
                              mainAxisSpacing:
                              10.0, // Spacing between rows
                              childAspectRatio:
                              2 / 2.3, // Aspect ratio for each item
                            ),
                            itemCount: 20, // Total number of items
                            itemBuilder:
                                (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailsScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft:
                                          Radius.circular(15.0),
                                          topRight:
                                          Radius.circular(15.0),
                                        ),
                                        child: Image.asset(
                                          'assets/image/b.png',
                                          // Replace with your image asset
                                          height: 120.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Name',
                                          style:const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          '\$Price.00',
                                          style:const TextStyle(
                                            color:
                                            Colors.deepOrange,
                                            fontSize: 16.0,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),

    );

  }
}
