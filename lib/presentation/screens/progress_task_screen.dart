import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  @override
  void initState() {
    // TODO: implement initState
    _getDataFromApi();
    super.initState();
  }
  void _getDataFromApi (){
    Get.find<ProgressTaskController>().getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        GetBuilder<ProgressTaskController>(
          builder: (progressTaskController) {
            return Visibility(
              visible: progressTaskController.inProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
                ),
              child: RefreshIndicator(
                onRefresh: () async{
                  _getDataFromApi();
                },
                child: Visibility(
                  visible: progressTaskController.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: progressTaskController.newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                    return taskCard(
                      taskItem: (progressTaskController.newTaskListWrapper.taskList![index]),
                      refreshList:(){
                        _getDataFromApi();
                      }
                    );
                  }),
                ),
              ),
            );
          }
        ),
        ),
      ),
    );
  }
}