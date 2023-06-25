import 'dart:typed_data';

import 'package:addycreates/vendor/controllers/vendor_register_controller.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();
  late String businessName;
  late String email;
  late String taxNumber;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  Uint8List? _image;
  selectGlleryImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  String? _taxStatus;
  List<String> _taxOptions = ['yes', 'no'];
  _saveVendorDetail() async {
    EasyLoading.show(status: 'please wait');
    if (_formKey.currentState!.validate()) {
      await _vendorController.registerVendor(businessName, email, phoneNumber,
          countryValue, stateValue, cityValue, _taxStatus!, taxNumber, _image);
    } else {
      print('d');
      EasyLoading.dismiss();
      setState(() {
        _formKey.currentState!.reset();
        _image = null;
      });
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.yellow])),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: () {
                                    selectGlleryImage();
                                  },
                                  icon: Icon(CupertinoIcons.photo),
                                ))
                    ],
                  )),
                ),
              );
            })),
        SliverToBoxAdapter(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    businessName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: 'Business Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: SelectState(
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax Registration',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Flexible(
                        child: Container(
                          width: 100,
                          child: DropdownButtonFormField(
                              hint: Text('Select'),
                              items: _taxOptions.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _taxStatus = value;
                                });
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                if (_taxStatus == 'yes')
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      onChanged: (value) {
                        taxNumber = value;
                      },
                      decoration: InputDecoration(labelText: 'Tx number'),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    _saveVendorDetail();
                  },
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
