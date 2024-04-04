import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/screens/sign_in_screen.dart';

import '../../widgets/background_widget.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController= TextEditingController();
  final TextEditingController _confirmPController= TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
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
                'Set Password',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SizedBox(height: 4,),
              Text('Minimum 8 characters with letters and numbers combination',
              style: TextStyle(color: Colors.grey),),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _confirmPController,
                decoration: InputDecoration(hintText: 'Confirm Password'),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Confirm')),
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
    ),
    );
  }
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}