import 'package:addycreates/vendor/views/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutterfire_ui/auth.dart';

class VendorAuth extends StatelessWidget {
  const VendorAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                  clientId: '1:338032851928:android:eec3361f3d6e6bd468d0ad'),
              PhoneProviderConfiguration()
            ],
          );
        }

        // Render your application if authenticated
        // return VendorAuth();
        // return VendorRegisterScreen();
        return LandingScreen();
      },
    );
  }
}
