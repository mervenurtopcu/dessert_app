import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../../firebase_options.dart';

//Data girmesine engellemek amacıyla
@immutable
class ApplicationStart {

  ApplicationStart._(); //static metodlar olacaksa bu class ı kapatıyoruz
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}