import 'package:flutter/material.dart';

class ProjectWidget extends StatelessWidget {
  const ProjectWidget({
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
      child: Container(
          height: _media.height / 1.9,
          width: _media.width / 3 + 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text("Put something"),
          )),
    );
  }
}
