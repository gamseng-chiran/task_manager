import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/cancel_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../widgets/empty_list_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _getDataFromApi();
  }
  void _getDataFromApi(){
    Get.find<CancelTaskController>().getCancelTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        GetBuilder<CancelTaskController>(
          builder: (cancelTaskController) {
            return Visibility(
              visible: cancelTaskController.inProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
                ),
              child: RefreshIndicator(
                onRefresh: () async{
                  _getDataFromApi();
                },
                child: Visibility(
                  visible: cancelTaskController.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: EmptyListWidget(),
                  child: ListView.builder(
                    itemCount: cancelTaskController.newTaskListWrapper.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                    return taskCard(
                      taskItem: (cancelTaskController.newTaskListWrapper.taskList![index]),
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
