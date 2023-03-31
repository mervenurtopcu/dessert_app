import 'package:desserts/features/dessert_view.dart';
import 'package:desserts/product/initialize/application_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../product/constants/index.dart';

Future<void> main() async {
  //Firebase proje başlangıç kodları
  await ApplicationStart.init();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConstants.whiteColor,
          elevation: 0,
          toolbarHeight: 150,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorConstants.whiteColor,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      home: const DessertView()
    );
  }
}
