import 'package:get/get.dart';
import 'package:task_manager/data/model/task_list_wrapper.dart';
import 'package:task_manager/data/model/utility/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';

class ProgressTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Fetching progress task failed';
  TaskListWrapper get newTaskListWrapper => _newTaskListWrapper;

  Future<bool> getProgressTaskList() async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if(response.isSuccess){
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    }
    else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}