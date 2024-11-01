import 'package:flutter/material.dart';
import 'package:stu_tech/data/tools/file_importer.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo(
      {super.key, required this.title, required this.subtitle, required this.icon});

  final String title;
  final String subtitle;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 3),
                color:ResColors.primaryElement,
                spreadRadius: 1,
                blurRadius: 6
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(
          fontSize: 16
        ),),
        leading: Icon(icon),
        tileColor: Colors.white,
      ),
    );
  }
}
