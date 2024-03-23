// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_item.dart';
import 'package:task_manager/data/model/task_list_wrapper.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../../data/model/utility/urls.dart';
import '../widgets/profile_bar.dart';
import '../widgets/snack_bar_message.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getAllCompletedTaskListInProgress = false;
  TaskListWrapper _completedTaskListWrapper= TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    _getAllcompletedTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        Visibility(
          visible: _getAllCompletedTaskListInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
            ),
          child: RefreshIndicator(
            onRefresh: () async{
              _getAllcompletedTaskList();
            },
            child: Visibility(
              visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(
                itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                return taskCard(
                  taskItem: (_completedTaskListWrapper.taskList![index]),
                  refreshList:(){
                    _getAllcompletedTaskList();
                  }
                );
              }),
            ),
          ),
        ),
        ),
      ),
    );
  }
  Future<void> _getAllcompletedTaskList() async {
    _getAllCompletedTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper= TaskListWrapper.fromJson(response.responseBody);
      _getAllCompletedTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCompletedTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Get completed task list has been failed');
      }
      
    }
  }
}