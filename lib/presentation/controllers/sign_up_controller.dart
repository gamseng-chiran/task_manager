
import 'package:get/get.dart';
import 'package:task_manager/data/model/response_object.dart';
import 'package:task_manager/data/model/utility/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Registration failed. Try again';

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
  ) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'password': password,
    };

    final ResponseObject response = await NetworkCaller.postRequest(
      Urls.registration,
      inputParams,
    );

    _inProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}