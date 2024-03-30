import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/utils/app_color.dart';

import 'presentation/screens/splash_screen.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}
class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      theme: _themeData,
      home: SplashScreen(),
    );
  }
  final ThemeData _themeData= ThemeData(
        inputDecorationTheme: InputDecorationTheme(
                fillColor: Colors.yellow,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8)
                )
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.themeColor,
                  textStyle:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              )
      );
}