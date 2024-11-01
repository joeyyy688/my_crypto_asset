// ignore_for_file: file_names, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_crypto_asset/constants/app_icons.dart';
import 'package:my_crypto_asset/constants/app_textSizes.dart';
import 'package:my_crypto_asset/models/userInfo.dart';
import 'package:my_crypto_asset/providers/userDataProvider.dart';
import 'package:my_crypto_asset/screens/homeScreen.dart';
import 'package:my_crypto_asset/utilities/utils.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign-in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // The user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  void getUserInfoAndLogIn() async {
    final userData = await Utils.getUserInfo();

    if (userData != null) {
      // store the locally fetched user data to provider
      Provider.of<UserDataProvider>(context, listen: false)
          .setUserInfoData(userData);

      // log user in
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  void initState() {
    super.initState();

    getUserInfoAndLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final userData = await signInWithGoogle();

                if (userData != null) {
                  // set user data to provider
                  Provider.of<UserDataProvider>(context, listen: false)
                      .setUserInfoData(UserInfoData(
                    displayName: userData.displayName!,
                    email: userData.email!,
                    photoUrl: userData.photoURL ?? '',
                  ));

                  // locally save user data to shared preferences
                  Utils.saveUserInfo(UserInfoData(
                    displayName: userData.displayName!,
                    email: userData.email!,
                    photoUrl: userData.photoURL ?? '',
                  ));

                  // log user in
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign in with',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: AppTextSizes.title3Semibold,
                        ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  SvgPicture.asset(
                    AppIcons.googleLogo,
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
