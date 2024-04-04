import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/presentation/screens/auth/set_password_screen.dart';
import 'package:task_manager/presentation/screens/sign_in_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';

import '../../widgets/background_widget.dart';

class PinVerification_Screen extends StatefulWidget {
  const PinVerification_Screen({super.key});

  @override
  State<PinVerification_Screen> createState() => _PinVerification_ScreenState();
}

class _PinVerification_ScreenState extends State<PinVerification_Screen> {
  final TextEditingController _pinController=TextEditingController();
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
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
                'Pin verification',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SizedBox(height: 4,),
              Text('A 6 digits verification code will be sent to your email address',
              style: TextStyle(color: Colors.grey),),
              SizedBox(
                height: 12,
              ),
              PinCodeTextField(
                controller: _pinController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: AppColors.themeColor,
                    selectedFillColor: Colors.white
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  appContext: context,
                ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SetPasswordScreen());
                    },
                    child: Text('verify')),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Have an account?", style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54
                ),),
                TextButton(onPressed: (() {
                  Get.offAll(() => SignInScreen());
                }), child: Text('Sign In'),),
              ],),
            ]),
          ),
        ),
      ),
    )
    );
  }
  @override
  void dispose() {
    _pinController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}