import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../../data/model/task_list_wrapper.dart';
import '../../data/model/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/snack_bar_message.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getAllCancelledTaskListInProgress =false;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    // TODO: implement initState
    _getAllCancelledTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        Visibility(
          visible: _getAllCancelledTaskListInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
            ),
          child: RefreshIndicator(
            onRefresh: () async{
              _getAllCancelledTaskList();
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
                    _getAllCancelledTaskList();
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

  Future<void> _getAllCancelledTaskList() async{
    _getAllCancelledTaskListInProgress = true;
    setState(() {
    });
    final response = await NetworkCaller.getRequest(Urls.cancelTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper= TaskListWrapper.fromJson(response.responseBody);
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Get cancelled task list has been failed');
      }
      
    }
  }
}