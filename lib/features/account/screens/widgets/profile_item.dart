import 'package:flutter/material.dart';

class ProfileItemCard extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;
  const ProfileItemCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: 80,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(color: Colors.white),
        ]),
        child: Center(
          child: ListTile(
            onTap: onTap,
            leading: icon,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
