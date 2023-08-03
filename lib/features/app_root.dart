import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
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
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: pages[index],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 3,
            spreadRadius: 0.2,
            offset: const Offset(0.1, 0.1),
          )
        ]),
        child: BottomNavigationBar(
          elevation: 20,
          // fixedColor: const Color.fromARGB(155, 50, 173, 234),
          // backgroundColor: Color.fromARGB(155, 236, 249, 255),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedItemColor: Colors.red,
          useLegacyColorScheme: false,
          currentIndex: index,
          selectedLabelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.red,
              ),
          unselectedLabelStyle:
              Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 12,
                  ),

          onTap: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.home,
                // color: Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyLight.category,
                // color: Colors.grey,
              ),
              label: 'Artists',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Trending',
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
                IconlyLight.profile,
                // color: Colors.grey,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
