import 'package:get/get.dart';
import 'package:task_manager/data/model/count_by_status_wrapper.dart';
import 'package:task_manager/data/service/network_caller.dart';

import '../../data/model/utility/urls.dart';

class CountTaskByStatusController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  CountByStatusWrapper _countByStatuswrapper= CountByStatusWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Fetch count by task status failed';
  CountByStatusWrapper get countByStatusWrapper => _countByStatuswrapper;

  Future<bool> getCountByTaskStatus() async{
    bool _isSuccess = false;
    _inProgress = true;
    update ();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if(response.isSuccess){
      _countByStatuswrapper= CountByStatusWrapper.fromJson(response.responseBody);
      _isSuccess = true;
    }
  else{
    _errorMessage= response.errorMessage;
  }
  _inProgress = false;
  update();
  return _isSuccess;
  } 
}