import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/model/user_data.dart';
import 'package:task_manager/data/model/utility/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/controllers/auth_controller.dart';

class UpdateProfileController extends GetxController{
  RxBool _inProgress = false.obs;
  Rx<XFile?> _pickedImage = Rx<XFile?>(null);

  bool get inProgress => _inProgress.value;

  XFile? get pickedImage => _pickedImage.value;

  void pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage.value = await imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<bool> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    _inProgress.value = true;

    String? photo ='';

    Map<String, dynamic> inputParams = {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };

    if (password.isNotEmpty) {
      inputParams['password'] = password;
    }

    if (_pickedImage.value != null) {
      List<int> bytes = await _pickedImage.value!.readAsBytes();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    _inProgress.value = false;

    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: email,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          mobile: mobile.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }
      return true;
    } else {
      return false;
    }
  }
}