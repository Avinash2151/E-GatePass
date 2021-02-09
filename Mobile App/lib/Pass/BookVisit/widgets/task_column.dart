import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskColumn extends StatelessWidget {
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  TaskColumn({
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: iconBackgroundColor,
          child: Icon(
            icon,
            size: 15.0,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
          ],
        )
      ],
    );
  }
}
