import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model/user_data.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/model/utility/urls.dart';
import '../widgets/background_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  // const UpdateProfileScreen({super.key});
  const UpdateProfileScreen({Key? key}) : super(key: key);
  static const String routeName = '/update_profile';

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _FNController=TextEditingController();
  TextEditingController _LNController= TextEditingController();
  TextEditingController _emailController= TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  XFile? _pickedImage;

  bool _updateProfileInProgress= false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = AuthController.userData?.email ?? '';
    _FNController.text = AuthController.userData?.firstName ?? '';
    _LNController.text = AuthController.userData?.lastName ?? '';
    _phoneController.text = AuthController.userData?.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: profilBar,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SizedBox(height: 48,),
              Text('Update your profile', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 24
              ),),
              SizedBox(height: 14,),
              imagePickerButton(),
              SizedBox(height: 8,),
              TextFormField(
                enabled: false,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
                
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _FNController,
                decoration: InputDecoration(
                  hintText: 'First name'
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _LNController,
                decoration: InputDecoration(
                  hintText: 'Last Name'
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                decoration: InputDecoration(
                  hintText: 'Phone'
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Password(optional)'
                ),
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _updateProfileInProgress==false,
                  replacement: Center(child: 
                  CircularProgressIndicator(),),
                  child: ElevatedButton(onPressed: () {
                    _updateProfile();
                  }, child: Icon(Icons.arrow_circle_right_outlined)),
                ),
              ),
            ],),
          ),
        ),),);
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        pickImageFromGallery();
      },
      child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)
                      )
                    ),
                    child: Text('Photo', style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(width: 8,),
                  Expanded(child: Text(_pickedImage?.name ?? '', 
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis
                  ),))
                ]),
              ),
    );
  }
  @override
  void dispose() {
    _emailController.dispose();
    _FNController.dispose();
    _LNController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> pickImageFromGallery()async{
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
    });
  }
  Future<void> _updateProfile() async{
    String? photo='';

    _updateProfileInProgress=true;
    setState() {
    };
    Map<String, dynamic> inputParams={
      'email' : _emailController.text.trim(),
      'firstName' : _FNController.text.trim(),
      'lastName' : _LNController.text.trim(),
      'mobile' : _phoneController.text.trim()
    };

    if(_passwordController.text.isNotEmpty){
      inputParams['password'] = _passwordController.text;
    }

    if(_pickedImage != null){
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo=base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response= await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    _updateProfileInProgress = false;
    if(response.isSuccess){
      if(response.responseBody['status']== 'success'){
        UserData userData=UserData(
          email: _emailController.text, 
          firstName: _FNController.text.trim(), 
          lastName: _LNController.text.trim(), 
          mobile: _phoneController.text.trim(), 
          photo: photo,
          );
          await AuthController.saveUserData(userData);
      }
      if(mounted){
        Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder:
           (context) => MainBottomNavScreen()), (route) => false);
      }
    }
    
    else{
      if(mounted){
        return;
      }
      setState() {
    };
      ShowSnackBarMeassage(context, 
      'Update profile failed. Try again');
    }
  }
}