import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notesapp/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async
{
  //init the hive
  await Hive.initFlutter();


  //open a box
  await Hive.openBox('MyBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit
    (
      designSize: Size(360, 740),
      splitScreenMode: true,
      minTextAdapt: true,
      builder:(context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          textTheme:  TextTheme(
      
            bodyMedium: TextStyle(color: Colors.white), // For medium body text
            titleLarge: TextStyle(color: Colors.white), // For titles
            
          ),
          primaryColor: Colors.deepPurple[300],
          appBarTheme: AppBarTheme(
            
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.sp), // Set AppBar title style
            backgroundColor: Colors.deepPurple[500], // Set global AppBar color
          ),
          useMaterial3: true, // this now works!
        ),
      );
      },
      
    );
  }
}