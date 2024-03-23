import 'package:flutter/material.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/task_card.dart';

import '../../data/model/task_list_wrapper.dart';
import '../../data/model/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/snack_bar_message.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  TaskListWrapper _progressTaskListWrapper= TaskListWrapper();
  bool _getAllProgressTaskListInProgress= false;

  @override
  void initState() {
    // TODO: implement initState
    _getAllProgressTaskList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profilBar,
      body: BackgroundWidget(
        child: Expanded(child: 
        Visibility(
          visible: _getAllProgressTaskListInProgress == false,
          replacement: Center(
            child: CircularProgressIndicator(),
            ),
          child: RefreshIndicator(
            onRefresh: () async{
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                return taskCard(
                  taskItem: (_progressTaskListWrapper.taskList![index]),
                  refreshList:(){
                    _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async{
    _getAllProgressTaskListInProgress = true;
    setState(() {
    });
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSuccess) {
      _progressTaskListWrapper= TaskListWrapper.fromJson(response.responseBody);
      _getAllProgressTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllProgressTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Get progress task list has been failed');
      }
      
    }
  }
}