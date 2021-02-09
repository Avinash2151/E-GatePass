import 'dart:core';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Device.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/models/models.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/Pass/BookVisit/widgets/UpdateVisit_screen.dart';
import 'package:keepapp/Pass/BookVisit/widgets/light_colors.dart';

class VisitCard extends StatelessWidget {
  final Visit visit;
  final VisitRepository _visitRepository;
  VisitCard(
      {Key key,
      @required this.visit,
      @required VisitRepository visitRepository})
      : assert(visitRepository != null),
        _visitRepository = visitRepository,
        super(key: key);
  double width;
  Device device;
  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 7),
        child: Card(
          shadowColor: Colors.deepOrange,
          elevation: 15.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'ID : ${visit.id}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),

                        //  GoogleFonts.montaga(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600
                        // ),
                      ),
                      Text(
                        "Status : ${visit.status.toString() == "req" ? "not visited" : "visited"}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        // GoogleFonts.montaga(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(visit.dateTime))}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        //  GoogleFonts.montaga(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Time: ${DateFormat("HH:MM a").format(DateTime.fromMillisecondsSinceEpoch(visit.dateTime))}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                        //  GoogleFonts.montaga(
                        //     color: Colors.black,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40.0),
                Material(
                  borderRadius: BorderRadius.circular(100.0),
                  color: LightColors.kDarkYellow,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return UpdateVisitScreen(
                          visitRepository: _visitRepository,
                          visit: visit,
                        );
                      }));
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
