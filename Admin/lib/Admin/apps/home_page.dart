library chips_choice;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Admin/apps/ActiveConferenceWidget.dart';
import 'package:keepapp/Admin/apps/ActiveVisitWidget.dart';
import 'package:keepapp/Admin/apps/CompletedConferenceWidget.dart';
import 'package:keepapp/Admin/apps/CompletedVisitWidget.dart';
import 'package:keepapp/Admin/apps/PendingConferenceWidget.dart';
import 'package:keepapp/Admin/apps/PendingVisitWidget.dart';
import 'package:keepapp/Admin/widget/card_tile.dart';
import 'package:keepapp/Admin/widget/chart_card_tile.dart';
import 'package:keepapp/Admin/widget/comment_widget.dart';
import 'package:keepapp/Admin/widget/profile_Widget.dart';
import 'package:keepapp/Admin/widget/project_widget.dart';
import 'package:keepapp/Admin/widget/quick_contact.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';
import 'package:keepapp/blocs/blocs.dart';
import 'package:provider/provider.dart';
import '../../Pass/BookVisit/widgets/light_colors.dart';
import 'package:keepapp/Device.dart';
import 'package:flutter/material.dart';

class HomePage_DashBoard extends StatefulWidget {
  // final VisitRepository _visitRepository;
  // final ConferenceRepository _conferenceRepository;
  // final SecurityCheckRepository _securityCheckRepository;
  // HomePage_DashBoard({
  //   Key key,
  //    @required VisitRepository visitRepository,
  //   @required ConferenceRepository conferenceRepository,
  //   @required SecurityCheckRepository securityCheckRepository,
  //  })  : assert(visitRepository != null),
  //       assert(conferenceRepository != null),
  //       assert(securityCheckRepository != null),
  //       _visitRepository = visitRepository,
  //       _conferenceRepository = conferenceRepository,
  //       _securityCheckRepository = securityCheckRepository,
  //       super(key: key);
  @override
  _HomePage_DashBoardState createState() => _HomePage_DashBoardState();
}

class _HomePage_DashBoardState extends State<HomePage_DashBoard> {
  Device device;
  double width;
  int vActive, vcompleted;
  int cActive, cCompleted;
  // VisitRepository get _visitRepository => widget._visitRepository;
  // ConferenceRepository get _conferenceRepository =>
  //     widget._conferenceRepository;
  // SecurityCheckRepository get _securityCheckRepository =>
  //     widget._securityCheckRepository;

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: 'Lato',
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
      //  GoogleFonts.breeSerif(
      //     color: LightColors.kDarkBlue,
      //     fontSize: 20.0,
      //     fontWeight: FontWeight.w700,
      //     letterSpacing: 1.2),
    );
  }

  static CircleAvatar timeIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.timer,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    width = MediaQuery.of(context).size.width;

    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading && state is ConferenceStatsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: bodyWidget(),
          );
        }
        return Container();
      },
    );
  }

  Widget bodyWidget() {
    final _media = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        children: <Widget>[
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          ActiveVisitWidget(),
                                          SizedBox(width: 20),
                                          ActiveConferenceWidget(),
                                          SizedBox(width: 20),
                                          PendingVisitWidget(),
                                          SizedBox(width: 20),
                                          PendingConferenceWidget(),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ///complted visit
                                              CompletedVisitWidget(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              //completed Conferences
                                              CompletedConferenceWidget(),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          ProjectWidget(media: _media),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                QuickContact(media: _media)
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                              // child: Row(
                              //   crossAxisAlignment: CrossAxisAlignment.stretch,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: <Widget>[
                              //     CommentWidget(media: _media),
                              //     SizedBox(
                              //       width: 20,
                              //     ),
                              //     ProfileWidget(media: _media),
                              //   ],
                              // ),
                              ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void openBookVisitPage() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => BookVisitScreen(
  //               visitRepository: _visitRepository,
  //             )),
  //   );
  // }

  // void openBookConferncePage() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => BookConferenceScreen(
  //               conferenceRepository: _conferenceRepository,
  //             )),
  //   );
  // }
}
