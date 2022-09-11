import 'package:flutter/material.dart';
import 'package:fluttertaskkssmart/view/loginscreen.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/companydetailsgetcontroller.dart';
import 'controller/helperclass.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Helper()),
    ChangeNotifierProvider(create: (_) => GetDetailsController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: const LoginScreen(),
        );
      },
    );
  }
}
