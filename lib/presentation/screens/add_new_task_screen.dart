import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/model/utility/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_bar.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController _titleController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  bool _addNewTaskInProgress=false;
  bool _shouldRefreshNewTaskList = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pop(context, _shouldRefreshNewTaskList);
        // Get.back(result: _shouldRefreshNewTaskList);
        return false;
      },
      child: Scaffold(
        appBar: profilBar,
        body: BackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                SizedBox(height: 48,),
                Text('Add new task', style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 24
                ),),
                SizedBox(height: 14,),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'title'
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8,),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'description',
                  ),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Please add description';
                    }
                  },
                ),
                SizedBox(height: 14,),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _addNewTaskInProgress==false,
                    replacement: Center(child: 
                    CircularProgressIndicator()
                    ),
                    child: ElevatedButton(onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _addNewTask();
                      }
                    }, child: Icon(Icons.arrow_circle_right_outlined)),
                  ),
                )
              ],),
            ),
          ),),
      ),
    );
  
  }
Future <void> _addNewTask() async {
    _addNewTaskInProgress= true;
    setState(() {
      
    });
    Map<String, dynamic> inputParams={
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'status': 'New'
    };
    final response= await NetworkCaller.postRequest(Urls.createTask, inputParams);
    _addNewTaskInProgress=false;
    setState(() {
      
    });
    if(response.isSuccess){
      _shouldRefreshNewTaskList = true;
      _descriptionController.clear();
      _titleController.clear();
      if(mounted){
        ShowSnackBarMeassage(context, 'New task has been added');
      }

    }
    else{
      if(mounted){
        ShowSnackBarMeassage(
          context, response.errorMessage ?? 'Add new task failed', true);
      }
    }

  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}