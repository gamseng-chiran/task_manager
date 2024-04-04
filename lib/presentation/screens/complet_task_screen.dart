// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';
import '../widgets/profile_bar.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }
  void _getDataFromApi(){
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        GetBuilder<CompletedTaskController>(
          builder: (completedTaskController) {
            return Visibility(
              visible: completedTaskController.inProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
                ),
              child: RefreshIndicator(
                onRefresh: () async{
                  _getDataFromApi();
                },
                child: Visibility(
                  visible: completedTaskController.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: completedTaskController.newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                    return taskCard(
                      taskItem: (completedTaskController.newTaskListWrapper.taskList![index]),
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