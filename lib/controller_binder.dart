import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/cancel_task_controller.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/controllers/signIn_controller.dart';
import 'package:task_manager/presentation/controllers/sign_up_controller.dart';
import 'package:task_manager/presentation/controllers/update_profile_controller.dart';

class ControllerBinder extends Bindings{
  
  @override
  void dependencies() {
    // Get.lazyPut(() => SignInController());
    Get.put(SignInController());
    // Get.lazyPut(() => CountTaskByStatusController());
    Get.put(CountTaskByStatusController());
    // Get.lazyPut(() => NewTaskController());
    Get.put(NewTaskController());
    // Get.lazyPut(() => CompletedTaskController());
    Get.put(CompletedTaskController());
    // Get.lazyPut(() => ProgressTaskController());
    Get.put(ProgressTaskController());
    // Get.lazyPut(() => CancelTaskController());
    Get.put(CancelTaskController());
    // TODO: implement dependencies
    Get.put(SignUpController());
    Get.put(UpdateProfileController());
  }}