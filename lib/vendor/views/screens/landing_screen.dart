import 'package:addycreates/vendor/models/vendor_user_model.dart';
import 'package:addycreates/vendor/views/auth/vendor_register.dart';
import 'package:addycreates/vendor/views/screens/main_vendor_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final CollectionReference _vendorStream =
        FirebaseFirestore.instance.collection('vendors');
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: _vendorStream.doc(_auth.currentUser!.uid).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (!snapshot.data!.exists) {
          return VendorRegisterScreen();
        }
        VendorUserModel vendorUserModel = VendorUserModel.fromJson(
            snapshot.data!.data()! as Map<String, dynamic>);
        if (vendorUserModel.approved == true) {
          return MainVendorScreen();
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    vendorUserModel.storeImage.toString(),
                    width: 90,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 15,
              ),
              Text(vendorUserModel.businessName.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 15,
              ),
              Text('your application has been successfully'),
              TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Text('sign-out'))
            ],
          ),
        );
      },
    ));
  }
}
