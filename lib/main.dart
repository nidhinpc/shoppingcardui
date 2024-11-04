import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcardui/controller/category_controller.dart';
import 'package:shoppingcardui/controller/my_cart_controller.dart';
import 'package:shoppingcardui/controller/product_detail_control.dart';
import 'package:shoppingcardui/view/homescreen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CategoryController(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductDetailControl(),
    ),
    ChangeNotifierProvider(
      create: (context) => MyCartController(),
    )
  ], child: Shopping()));
}

class Shopping extends StatelessWidget {
  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
