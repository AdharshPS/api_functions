import 'package:flutter/material.dart';
import 'package:model_scample/controller/home_screen_controller.dart';
import 'package:model_scample/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
