import 'package:employee_attendance/screens/attendance_screen.dart';
import 'package:employee_attendance/screens/calender_screen.dart';
import 'package:employee_attendance/screens/chat_screen.dart';
import 'package:employee_attendance/screens/leave_list_screen.dart';
import 'package:employee_attendance/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  List<IconData> navigationIcons =[
  FontAwesomeIcons.solidCalendarDays,
  FontAwesomeIcons.check,
  FontAwesomeIcons.adversal,
  FontAwesomeIcons.solidPaperPlane,
  FontAwesomeIcons.airbnb
  ];

  int currentIndex=1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children:const [
          CalenderScreen(),
          AttendanceScreen(),
          
          EmployeeLeaveListScreen(),
          
          ChatScreen(receiverId:'5da9f81e-f970-4299-99fe-b9e3a9e31357' ),
          ProfileScreen(),
          
          
          
          
        ],
      ),
        bottomNavigationBar: Container(
          height: 70,
          margin: const EdgeInsets.only(left: 12,right: 12,bottom: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow:[
              BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(2, 2))
            ]
          ),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              for(int i=0;i<navigationIcons.length;i++)...{
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        currentIndex =i;
                      });
                    },
                    child: Center(
                      child: FaIcon(navigationIcons[i],
                      color: i == currentIndex? Colors.redAccent:Colors.black54,
                      size: i ==currentIndex? 30: 26,
                      ),
                    ),
                  )
                )
              }
            ],
          ),
        ),
    );
  }
}
