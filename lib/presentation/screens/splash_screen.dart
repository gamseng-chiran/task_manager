import 'package:flutter/material.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  Future<void> _moveToNextScreen() async{
    await Future.delayed(Duration(seconds:2));

     bool isLoggedIn= await AuthController.isUserLoggedIn();

    if (mounted){
      if(isLoggedIn){
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => MainBottomNavScreen()),);
    }
    else{
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => SignInScreen()),);

    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: AppLogo(),)
    );
  }
}

