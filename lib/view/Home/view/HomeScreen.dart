import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mti_android/view/Home/view/tabs/ListDataScreen.dart';
import 'package:mti_android/view/Home/view/tabs/ProfileScreen.dart';
import 'package:sqflite/sqflite.dart';
import '../controller/HomeController.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find();
  var isInternet = false.obs;
  int _selectedIndex = 0;
  List _buildScreens =
    [

      ListDataScreen(),
      ProfileScreen(),
    ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(

          currentIndex: _selectedIndex,
        onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
          backgroundColor: Color(0XFF181C4B),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
