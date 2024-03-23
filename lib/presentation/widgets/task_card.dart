// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_item.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/model/utility/urls.dart';

class taskCard extends StatefulWidget {
  const taskCard({
    Key? key,
    required this.taskItem,
    required this.refreshList
  }) : super(key: key);
  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<taskCard> createState() => _taskCardState();
}

class _taskCardState extends State<taskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(widget.taskItem.title ?? '', style: TextStyle(fontWeight: FontWeight.bold),),
          Text(widget.taskItem.description ?? ''),
          Text('Date : ${widget.taskItem.createdDate}'),
          Row(children: [
            Chip(label: Text(widget.taskItem.status ?? '')),
            Spacer(),
            Visibility(
              visible: _updateTaskStatusInProgress == false,
              replacement: CircularProgressIndicator(),
              child: IconButton(onPressed: (() {
                _showUpdateStatusDialog(widget.taskItem.sId!);
              }), icon: Icon(Icons.edit)),
            ),
            Visibility(
              visible: _deleteTaskInProgress ==false,
              replacement: CircularProgressIndicator(),
              child: IconButton(onPressed: (() {
                _deleteTaskById(widget.taskItem.sId!);
              }), icon: Icon(Icons.delete)),
            )
          ],)
        ]),
      ),
    );
  }

  void _showUpdateStatusDialog(String id){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Select status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          ListTile(title: Text('New'), 
          trailing: _isCurrentStatus('New') ? Icon(Icons.check) : null,
          onTap: () {
            if(_isCurrentStatus('New')){
              return;
            }
            _updateTaskById(id, 'New');
            Navigator.pop(context);
          },
          ),
          ListTile(title: Text('Completed'), 
          trailing: _isCurrentStatus('completed') ? Icon(Icons.check) : null,
          onTap: () {
            if(_isCurrentStatus('Completed')){
              return;
            }
            _updateTaskById(id, 'Completed');
            Navigator.pop(context);
          },
          ),
          ListTile(title: Text('Progress'), 
          trailing: _isCurrentStatus('Progress') ? Icon(Icons.check) : null,
          onTap: () {
            if(_isCurrentStatus('Progress')){
              return;
            }
            _updateTaskById(id, 'Progress');
            Navigator.pop(context);
          },
          ),
          ListTile(title: Text('Cancelled'), 
          trailing: _isCurrentStatus('Cancelled') ? Icon(Icons.check) : null,
          onTap: () {
            if(_isCurrentStatus('Cancelled')){
              return;
            }
            _updateTaskById(id, 'Cancelled');
            Navigator.pop(context);
          },
          ),
        ]),
      );
    });
  }

  bool _isCurrentStatus(String status){
    return widget.taskItem.status! ==status;
  }

  Future<void> _updateTaskById(String id, String status) async{
    _updateTaskStatusInProgress = true;
    setState(() {
    });
    final response= await NetworkCaller.getRequest(Urls.updateTastStatus(id, status));
    _updateTaskStatusInProgress = false;
    if(response.isSuccess){
      _updateTaskStatusInProgress=false;
      widget.refreshList();
    }
    else{
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Update task status has been failed');
      }
    }
  }
  Future<void> _deleteTaskById (String id) async{
    _deleteTaskInProgress = true;
    setState(() {
    });
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if(response.isSuccess){
      widget.refreshList();
    }
    else{
      
      setState(() {});
      if (mounted) {
        ShowSnackBarMeassage(context,
            response.errorMessage ?? 'Delete task has been failed');
      }
    }
  }
}
