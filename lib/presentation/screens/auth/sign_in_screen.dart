import 'package:flutter/material.dart';
import 'package:task_manager/data/model/login_responce.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/auth/email_verification_screen.dart';
import 'package:task_manager/presentation/screens/auth/sign_up_screen.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../../data/model/response_object.dart';
import '../../../data/model/utility/urls.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  bool _isLogInProgress= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundWidget(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                'Get Started With',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (String? value) {
                      if(value?.trim().isEmpty ??true){
                        return 'Please enter your email';
                      }
                      return null;
                    },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                validator: (String? value) {
                      if(value?.trim().isEmpty ?? true){
                        return 'Please enter your password';
                      }
                      if(value!.trim().length <7){
                        return 'Password shuld be more than 6 digit';
                      }
                      return null;
                    },
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _isLogInProgress==false,
                  replacement: Center(
                    child: CircularProgressIndicator()),
                  child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _signIn();
                        }
                        
                      },
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen()));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Don't have an account?", style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54
                ),),
                TextButton(onPressed: (() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()),);
                }), child: Text('Sign Up'),),
              ],),
            ]),
          ),
        ),
      ),
    ));
  }
  Future<void> _signIn() async{
    _isLogInProgress=true;
    setState(() {
      
    });
    Map<String, dynamic> inputParams={
      'email':emailController.text.trim(),
      'password':passwordController.text.trim()
    };
    final ResponseObject response=await NetworkCaller.postRequest(Urls.logIn, inputParams, fromSignin: true);

    _isLogInProgress=false;
    setState(() {
      
    });

    if(response.isSuccess){
      if(!mounted){
        return;
      }
      LoginResponse loginResponse= LoginResponse.fromJson(response.responseBody);
      
      await AuthController.saveUserData(loginResponse.userData);
      await AuthController.saveUserToken(loginResponse.token);
      if(mounted){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) => MainBottomNavScreen()), (route) => false);
    }
    }
    else{
      if(mounted){
        ShowSnackBarMeassage(context, response.errorMessage ?? 'Log in faled. Try again');
      }
    }
  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
