import 'package:flutter/material.dart';
import 'package:task_manager/data/model/count_by_status_wrapper.dart';
import 'package:task_manager/data/model/task_list_wrapper.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';
import 'package:task_manager/presentation/widgets/task_counter_card.dart';

import '../../data/model/utility/urls.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByStatusInProgress = false;
  bool _getNewTaskListInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromApi();
  }
  void _getDataFromApi(){
    _getAllTaskCountByStatus();
    _getAllNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusInProgress == false,
                replacement: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: _getNewTaskListInProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApi(),
                  child: Visibility(
                    visible: _newTaskListWrapper.taskList?.isNotEmpty ?? false,
                    replacement: EmptyListWidget(),
                    child: ListView.builder(
                        itemCount: _newTaskListWrapper.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return taskCard(
                              taskItem: _newTaskListWrapper.taskList![index],
                              refreshList: () {
                                _getDataFromApi();
                              },
                              );
                              
                        }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScreen(),),);
              if(result != null && result == true){
                _getDataFromApi();
              }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
        itemBuilder: ((context, index) {
          return TastkCounterCard(
              amount:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ?? 0,
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
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
  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Get tak count by status has been failed');
      }
    }
  }

  Future<void> _getAllNewTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {_getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Get new task list has been failed');
      }
      
    }
  }
}
