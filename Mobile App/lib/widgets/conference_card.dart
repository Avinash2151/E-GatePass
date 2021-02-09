import 'dart:core';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keepapp/Device.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/src/models/models.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookConference/widgets/UpdateConferenceScreen.dart';
import 'package:keepapp/Pass/BookConference/widgets/light_colors.dart';

class ConferenceCard extends StatelessWidget {
  final Conference conference;
  final ConferenceRepository _conferenceRepository;
  ConferenceCard(
      {Key key,
      @required this.conference,
      @required ConferenceRepository conferenceRepository})
      : assert(conferenceRepository != null),
        _conferenceRepository = conferenceRepository,
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
                        'ID : ${conference.id}',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montaga(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Status : ${conference.status.toString() == "req" ? "not done" : "done"}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montaga(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.fromMillisecondsSinceEpoch(conference.startTime))}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montaga(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Start Time: ${DateFormat("HH:MM a").format(DateTime.fromMillisecondsSinceEpoch(conference.startTime))}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montaga(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "End Time: ${DateFormat("HH:MM a").format(DateTime.fromMillisecondsSinceEpoch(conference.endTime))}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montaga(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
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
                        return UpdateConferenceScreen(
                          conferenceRepository: _conferenceRepository,
                          conference: conference,
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
