import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_crypto_asset/constants/app_icons.dart';
import 'package:my_crypto_asset/providers/appStateProvider.dart';
import 'package:my_crypto_asset/providers/userDataProvider.dart';
import 'package:my_crypto_asset/routing/routeGenerator.dart';
import 'package:my_crypto_asset/theme/themeData.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (context) => UserDataProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  // preload all SVG Icons
  await AppIcons.preloadIconsSVGs();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'MY-CRYPTO-APP',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: lightThemeData(context),
      ),
    );
  }
}
