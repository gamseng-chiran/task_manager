import 'package:flutter/material.dart';
import 'package:task_manager/presentation/screens/cancelled_task_screen.dart';
import 'package:task_manager/presentation/screens/complet_task_screen.dart';
import 'package:task_manager/presentation/screens/new_task_screen.dart';
import 'package:task_manager/presentation/screens/progress_task_screen.dart';
import 'package:task_manager/presentation/utils/app_color.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _currentSelectedIndex=0;
  final List<Widget> _screens=[
    NewTaskScreen(),
    CompleteTaskScreen(),
    ProgressTaskScreen(),
    CancelledTaskScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          _currentSelectedIndex=index;
          if(mounted){
            setState(() {
              
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.file_copy_outlined),label: 'New task'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.abc_rounded),label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.class_rounded), label: 'Cancelled')
        ],
      ),
    );
  }
}