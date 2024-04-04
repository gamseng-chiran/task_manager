

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _FNController = TextEditingController();
  final TextEditingController _LNController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignUpController _signUpController = Get.find<SignUpController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRegistrationInProgess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Join With Us',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _FNController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _LNController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 11,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Please enter your password';
                    }
                    if (value!.trim().length < 7) {
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
                  child: GetBuilder<SignUpController>(
                    builder: (signUpController) {
                      return Visibility(
                        visible: signUpController.inProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _signUp();
                              }
                            },
                            child: Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    TextButton(
                      onPressed: (() {
                        Get.back();
                      }),
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _signUp () async{
    final result = await _signUpController.signUp(
      _emailController.text.trim(),
      _FNController.text.trim(),
      _LNController.text.trim(),
      _mobileController.text.trim(),
      _passwordController.text,
    );
    if(result){
      if(mounted){
        ShowSnackBarMeassage(context, "Registration successful! Please log in");
        Get.back();
      }
    }
    else{
      if(mounted){
        ShowSnackBarMeassage(context, _signUpController.errorMessage);
      }
    }
  }

  // Future<void> _signUp() async {
  //   _isRegistrationInProgess = true;
  //   setState(() {});
  //   Map<String, dynamic> inputParams = {
  //     'email': _emailController.text.trim(),
  //     'firstName': _FNController.text.trim(),
  //     'lastName': _LNController.text.trim(),
  //     'mobile': _mobileController.text.trim(),
  //     'password': _passwordController.text
  //   };
  //   final ResponseObject response =
  //       await NetworkCaller.postRequest(Urls.registration, inputParams);
  //   _isRegistrationInProgess = false;
  //   setState(() {});
  //   if (response.isSuccess) {
  //     if (mounted) {
  //       ShowSnackBarMeassage(context, 'Registration successful! Please log in');
  //       Get.back();
  //     }
  //   } else {
  //     if (mounted) {
  //       ShowSnackBarMeassage(context, 'Registration failed. Try again', true);
  //     }
  //   }
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _FNController.dispose();
    _LNController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
