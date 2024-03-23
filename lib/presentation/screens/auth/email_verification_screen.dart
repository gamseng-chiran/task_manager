import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';

import '../../widgets/background_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController= TextEditingController();
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
                'Your email address',
                style: Theme.of(context).textTheme.titleLarge
              ),
              SizedBox(height: 4,),
              Text('A 6 digits verification code will be sent to your email address',
              style: TextStyle(color: Colors.grey),),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PinVerification_Screen()));
                    },
                    child: Icon(Icons.arrow_circle_right_outlined)),
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
                  Navigator.pop(context);
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
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}