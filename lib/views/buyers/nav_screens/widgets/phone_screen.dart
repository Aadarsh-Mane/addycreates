import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderMessScreen extends StatefulWidget {
  @override
  _OrderMessScreenState createState() => _OrderMessScreenState();
}

class _OrderMessScreenState extends State<OrderMessScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _checkbox1Value = false;
  bool _checkbox2Value = false;
  TimeOfDay _deliveryTime = TimeOfDay.now();

  @override
  void dispose() {
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note:'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                ListTile(
                  title: Text(
                      'choose the daily timing of delivery click on time '),
                  trailing: Text(_deliveryTime.format(context)),
                  onTap: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: _deliveryTime,
                    );
                    if (selectedTime != null) {
                      setState(() {
                        _deliveryTime = selectedTime;
                      });
                    }
                  },
                ),
                CheckboxListTile(
                  title: Text('Checkbox 1'),
                  value: _checkbox1Value,
                  onChanged: (newValue) {
                    setState(() {
                      _checkbox1Value = newValue!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Checkbox 2'),
                  value: _checkbox2Value,
                  onChanged: (newValue) {
                    setState(() {
                      _checkbox2Value = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Retrieve the entered data
                      final address = _addressController.text;
                      final email = _emailController.text;
                      final phoneNumber = _phoneNumberController.text;

                      // Create a new collection in Firestore and add a new document with the entered fields
                      final firestoreInstance = FirebaseFirestore.instance;
                      firestoreInstance.collection('mess').add({
                        'address': address,
                        'email': email,
                        'phoneNumber': phoneNumber,
                        'deliveryTime': _deliveryTime.format(context),
                        'checkbox1': _checkbox1Value,
                        'checkbox2': _checkbox2Value,
                      }).then((value) {
                        // Document created successfully
                        Navigator.pop(
                            context); // Go back to the previous screen

                        // Show snackbar indicating successful submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Form submitted successfully u will get contact by this number 9167787316!'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }).catchError((error) {
                        // Error occurred while creating the document
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text(
                                'An error occurred while saving the data.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
