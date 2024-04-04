import 'package:get/get.dart';
import 'package:task_manager/data/model/task_list_wrapper.dart';
import 'package:task_manager/data/model/utility/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';

class CompletedTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Fetching completed task failed';
  TaskListWrapper get newTaskListWrapper => _newTaskListWrapper;

  Future<bool> getCompletedTaskList() async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
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