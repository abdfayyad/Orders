import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:programing_languages/Client/Stores/bloc/cubit.dart';
import 'package:programing_languages/Client/Stores/bloc/status.dart';
import 'package:programing_languages/Client/Stores/bloc/status.dart';
import 'package:programing_languages/Client/Stores/bloc/status.dart';

import 'package:programing_languages/Client/Stores/products/Products.dart';

import 'package:programing_languages/utils/color.dart';


class StoresClient extends StatefulWidget {
  const StoresClient({super.key});

  @override
  _StoresClientState createState() => _StoresClientState();
}

class _StoresClientState extends State<StoresClient> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _Storess = List.generate(5, (index) => 'Stores ${index + 1}'); // Dummy data
  List<String> ?_filteredStoress;

  @override
  void initState() {
    super.initState();
    _filteredStoress = _Storess;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
StoresModel? storesModel;
  void _onSearchChanged() {
    setState(() {
      _filteredStoress = _Storess
          .where((Stores) =>
          Stores.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoresClientCubit()..getStores(),
      child: BlocConsumer<StoresClientCubit, StoresClientStatus>(
        listener: (context, state) {
          if(state is StoresSuccess) {
            storesModel=state.storesModel;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Expanded(
                child:   storesModel?.stores!=null

                      ? ListView.builder(
                    itemCount: storesModel?.stores?.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductsScreenClient(id: "${storesModel!.stores![index].id}",)));

                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2,left: 8.0,right: 8.0,bottom: 2),
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          "assets/image/im.png",
                                        )),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${storesModel!.stores![index].name}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor

                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Address: ${storesModel!.stores![index].location}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            color: mainColor
                                            ,overflow: TextOverflow.ellipsis

                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  )
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
