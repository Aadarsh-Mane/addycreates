import 'package:addycreates/controllers/auth_controller.dart';
import 'package:addycreates/utils/show_SnackBar.dart';
import 'package:addycreates/views/buyers/auth/register_screen.dart';
import 'package:addycreates/views/buyers/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

// late String email;

// late String password;
Future<bool> checkUserExists(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true; // User exists
  } catch (e) {
    return false; // User does not exist
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  String email = '';

  String password = '';

  @override
  void initState() {
    super.initState();
    // Check if user credentials are stored in shared preferences
    _loadUserCredentials();
    _checkLoggedIn(); // Check if the user is already logged in
  }

  _loadUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');
    if (storedEmail != null && storedPassword != null) {
      setState(() {
        email = storedEmail;
        password = storedPassword;
      });
    }
  }

  _checkLoggedIn() async {
    if (await FirebaseAuth.instance.currentUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) {
          return MainScreen();
        }),
      );
    }
  }

  _loginUsers() async {
    EasyLoading.show(status: 'Logging in...');

    setState(() {
      _isLoading = true;
    });

    // Check if user exists in Firebase
    bool userExists = await checkUserExists(email, password);

    if (userExists) {
      await _authController.loginUsers(email, password);

      if (_formKey.currentState!.validate()) {
        // Save user credentials to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('password', password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return MainScreen();
          }),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnack(context, 'Please enter your credentials correctly');
      }
    } else {
      setState(() {
        _isLoading = false;
      });

      showSnack(context, 'User does not exist. Please register first.');
    }
    EasyLoading.dismiss(); // Hide loading indicator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Customer\'s Account',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  email = value;
                },
                initialValue: email, // Pre-fill the email field
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  password = value;
                },
                initialValue: password, // Pre-fill the password field
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                EasyLoading.instance
                  ..maskType = EasyLoadingMaskType.black
                  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                  ..loadingStyle = EasyLoadingStyle.dark
                  ..indicatorSize = 45.0
                  ..radius = 10.0
                  ..progressColor = Colors.yellow
                  ..backgroundColor = Colors.black.withOpacity(0.8)
                  ..textColor = Colors.white
                  ..maskColor = Colors.blue.withOpacity(0.5)
                  ..userInteractions = false;
                _loginUsers();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      letterSpacing: 5,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Need an account? ',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) {
                        return BuyerRegisterScreen();
                      })),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
