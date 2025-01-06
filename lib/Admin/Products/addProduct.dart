import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:programing_languages/Admin/App_drawer/app_dawer.dart';
import 'package:programing_languages/Admin/Products/bloc/cubit.dart';
import 'package:programing_languages/Admin/Products/bloc/status.dart';
import 'package:programing_languages/utils/end_point.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';
import 'package:programing_languages/utils/textField.dart';


class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  DateTime? _productionDate;
  DateTime? _expirationDate;
  File? _image;
  List<String> _colors = [];

  Future<void> _selectDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (field == 'production') {
          _productionDate = picked;
        } else if (field == 'expiration') {
          _expirationDate = picked;
        }
      });
    }
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        _image = File(image.path);
      }
    });
  }

  void _addColor() {
    final color = _colorController.text.trim();
    if (color.isNotEmpty) {
      setState(() {
        _colors.add(color);
        _colorController.clear();
      });
    }
  }

  void _removeColor(int index) {
    setState(() {
      _colors.removeAt(index);
    });
  }

  Future<void> _postProduct() async {
    if (_image == null) {
      // Handle the case where no image is selected
      print('No image selected');
      return;
    }

    // Prepare the dates as strings
    String? productionDateString = _productionDate != null
        ? '${_productionDate?.year}-${_productionDate?.month.toString().padLeft(2, '0')}-${_productionDate?.day.toString().padLeft(2, '0')}'
        : null;
    String? expirationDateString = _expirationDate != null
        ? '${_expirationDate?.year}-${_expirationDate?.month.toString().padLeft(2, '0')}-${_expirationDate?.day.toString().padLeft(2, '0')}'
        : null;

    // Create a multipart request
    final request = http.MultipartRequest('POST', Uri.parse('$BASE_URL/api/admin/products'));

    // Add headers
    request.headers['Authorization'] = 'Bearer ${SharedPref.getData(key: 'token')}';
    request.headers['Accept'] = 'application/json';

    // Add fields
    request.fields['name'] = _nameController.text;
    request.fields['price'] = _priceController.text;
    request.fields['description'] = _descriptionController.text;
    request.fields['quantity'] = _quantityController.text;
    request.fields['colors'] = jsonEncode(_colors);
    if (productionDateString != null) {
      request.fields['production_date'] = productionDateString;
    }
    if (expirationDateString != null) {
      request.fields['expiration_date'] = expirationDateString;
    }

    // Add the image file
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    // Send the request and get the response
    final response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AppDrawerAdmin()), (Route<dynamic> route) => false);
      Flushbar(
          titleText: Text("Success", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.yellow[600], fontFamily:"ShadowsIntoLightTwo"),),
          messageText: Text("Product add successfuly", style: TextStyle(fontSize: 16.0, color: Colors.green),),
          duration:  Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8)
      ).show(context);
      print('Product added successfully');
      print('Response: ${await response.stream.bytesToString()}'); // Print response body if needed
    } else {
      print('Failed to add product');
      print('Response: ${await response.stream.bytesToString()}'); // Print response body if needed
    }
  }




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShowProductsAdminCubit(),
      child: BlocConsumer<ShowProductsAdminCubit, ShowProductsAdminStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Product'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _getImage,
                      child: GestureDetector(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: _image != null
                              ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                              : Icon(
                            Icons.add_photo_alternate,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    myTextField(controller: _nameController, hintText: 'Name'),
                    SizedBox(height: 20.0),
                    myTextField(controller: _priceController, hintText: 'Price',keyboardType:TextInputType.number ),
                    SizedBox(height: 20.0),
                    myTextField(controller: _quantityController, hintText: 'Quantity',keyboardType:TextInputType.number),
                    SizedBox(height: 20.0),
                    myTextField(controller: _descriptionController, hintText: 'Description'),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _colorController,
                            decoration: InputDecoration(
                              hintText: 'Color',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _addColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Wrap(
                      children: _colors.map((color) {
                        int index = _colors.indexOf(color);
                        return Chip(
                          label: Text(color),
                          onDeleted: () => _removeColor(index),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width: 1, color: Colors.blue),
                              ),
                              hintText: "Production Date",
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: _productionDate != null
                                  ? '${_productionDate?.day}/${_productionDate?.month}/${_productionDate?.year}'
                                  : '',
                            ),
                            readOnly: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'production'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              labelStyle: TextStyle(color: Colors.blue),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(width: 1, color: Colors.blue),
                              ),
                              hintText: "Expiration Date",
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.blue, width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            keyboardType: TextInputType.datetime,
                            controller: TextEditingController(
                              text: _expirationDate != null
                                  ? '${_expirationDate?.day}/${_expirationDate?.month}/${_expirationDate?.year}'
                                  : '',
                            ),
                            readOnly: true,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, 'expiration'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _postProduct,
                      child: Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
