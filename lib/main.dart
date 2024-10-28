import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcardui/controller/controller.dart';
import 'package:shoppingcardui/view/homescreen/home_screen.dart';

void main() {
  runApp(Shopping());
}

class Shopping extends StatelessWidget {
  const Shopping({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        )
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}
