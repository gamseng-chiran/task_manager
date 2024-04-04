import 'package:get/get.dart';

import '../../data/model/login_responce.dart';
import '../../data/model/response_object.dart';
import '../../data/model/utility/urls.dart';
import '../../data/service/network_caller.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  String get errorMessage=>_errorMessage ?? "Log in faled. Try again";
  bool get inProgess => _inProgress;

  Future<bool> signIn (String email, String password) async{
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams={
      'email':email,
      'password':password
    };
    final ResponseObject response=await NetworkCaller.postRequest(Urls.logIn, inputParams, fromSignin: true);

    _inProgress=false;

    if(response.isSuccess){
      LoginResponse loginResponse= LoginResponse.fromJson(response.responseBody);
      
      await AuthController.saveUserData(loginResponse.userData);
      await AuthController.saveUserToken(loginResponse.token);
      update();
      return true;
    }
    else{
      _errorMessage= response.errorMessage;
      update();
      return false;
      }
    } 

  }

