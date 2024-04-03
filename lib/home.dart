import 'package:ahmet_uygun_eindproject/firebase/firebase_functions.dart';
import 'package:ahmet_uygun_eindproject/pages/Activities.dart';
import 'package:ahmet_uygun_eindproject/pages/Profile.dart';
import 'package:ahmet_uygun_eindproject/pages/Summary.dart';
import 'package:ahmet_uygun_eindproject/pages/Todo.dart';
import 'package:flutter/material.dart';
import 'widget/create_activity_form.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [
     ActivityPage(),
    const SummaryPage(),
    const TodoPage(),
    const ProfilePage(),
  ];





  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen =  ActivityPage();

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (context)=> CreateActivity()
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =  ActivityPage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dashboard,
                            color: currentTab == 0 ? Colors.greenAccent : Colors.grey),
                        Text(
                          'Activities',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.greenAccent : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const SummaryPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.align_vertical_bottom,
                            color: currentTab == 1 ? Colors.greenAccent : Colors.grey),
                        Text(
                          'Summary',
                          style: TextStyle(
                              color:
                              currentTab == 1 ? Colors.greenAccent : Colors.grey),
                        )
                      ],
                    ),
                  )

                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const TodoPage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            color: currentTab == 2 ? Colors.greenAccent : Colors.grey),
                        Text(
                          'To Do',
                          style: TextStyle(
                              color:
                              currentTab == 2 ? Colors.greenAccent : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfilePage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,
                            color: currentTab == 3 ? Colors.greenAccent : Colors.grey),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                              currentTab == 3 ? Colors.greenAccent : Colors.grey),
                        )
                      ],
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

