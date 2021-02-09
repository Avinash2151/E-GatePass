import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key,
    @required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      color: Colors.white,
      child: Container(
        height: _media.height / 2.3,
        width: _media.width / 3.2 - 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child:
           Center(
             child: Text("Profile"),
           )

      ),
    );
  }
}
