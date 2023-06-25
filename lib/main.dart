import 'package:addycreates/provider/cart_provider.dart';
import 'package:addycreates/provider/product_provider.dart';
import 'package:addycreates/vendor/views/auth/vendor_auth.dart';
import 'package:addycreates/vendor/views/screens/landing_screen.dart';
import 'package:addycreates/vendor/views/screens/main_vendor_screen.dart';
import 'package:addycreates/views/buyers/auth/login_screen.dart';
import 'package:addycreates/views/buyers/auth/register_screen.dart';
import 'package:addycreates/views/buyers/main_screen.dart';
import 'package:addycreates/views/buyers/product_detail/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) {
      return ProductProvider();
    }),
    ChangeNotifierProvider(create: (_) {
      return CartProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Brand-Bold',
      ),
      // home: LoginScreen(),
      // home: MainScreen(),
      // home: VendorAuth(),
      // home: LandingScreen(),
      home: MyHomePage(),
      // home: MainVendorScreen(),
      builder: EasyLoading.init(),
    );
  }
}
