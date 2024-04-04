import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controllers/new_task_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

import '../../data/model/task_count_by_status_data.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }
  void _getDataFromApi(){
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
              builder: (countTaskBystatusController) {
                return Visibility(
                    visible: countTaskBystatusController.inProgress == false,
                    replacement: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(),
                    ),
                    child: taskCounterSection(
                      countTaskBystatusController.countByStatusWrapper.listOfTaskByStatusData ?? []),);
              }
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskControlleer) {
                  return Visibility(
                    visible: newTaskControlleer.inProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () async => _getDataFromApi(),
                      child: Visibility(
                        visible: newTaskControlleer.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                        replacement: EmptyListWidget(),
                        child: ListView.builder(
                            itemCount: newTaskControlleer.newTaskListWrapper.taskList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return taskCard(
                                  taskItem: newTaskControlleer.newTaskListWrapper.taskList![index],
                                  refreshList: () {
                                    _getDataFromApi();
                                  },
                                  );
                                  
                            }),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () async {
          final result = await Get.to(() => AddNewTaskScreen());
              if(result != null && result == true){
                _getDataFromApi();
              }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget taskCounterSection(List<TaskCountByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: listOfTaskCountByStatus.length,
        itemBuilder: ((context, index) {
          return TastkCounterCard(
              amount:
                  listOfTaskCountByStatus[index].sum ?? 0,
              title: listOfTaskCountByStatus[index].sId ??
                  '');
        }),
        separatorBuilder: ((_, __) {
          return SizedBox(
            width: 8,
          );
        }),
      ),
    );
  }
}
