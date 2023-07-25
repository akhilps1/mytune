import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';
import 'package:mytune/features/authentication/screens/widgets/otp_widget.dart';
import 'package:mytune/general/serveices/constants.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        // fixedColor: const Color.fromARGB(155, 50, 173, 234),
        // backgroundColor: Color.fromARGB(155, 236, 249, 255),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: const Color.fromARGB(155, 55, 188, 255),

        currentIndex: index,

        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              // color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_view_outlined,
              // color: Colors.grey,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              // color: Colors.grey,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
              // color: Colors.grey,
            ),
            label: 'Accounts',
          ),
        ],
      ),
    );
  }
}
