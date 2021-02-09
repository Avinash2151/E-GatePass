library chips_choice;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/src/conference_repository.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/blocs/blocs.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:keepapp/widgets/filteredConferences.dart';
import 'package:keepapp/widgets/filtered_visit.dart';
import 'package:keepapp/widgets/stats.dart';
import 'package:provider/provider.dart';

import 'Pass/BookVisit/widgets/light_colors.dart';
import 'Pass/BookVisit/widgets/task_column.dart';

import 'package:keepapp/Device.dart';
import 'package:keepapp/Pass/BookVisit/widgets/BookVisit_Screen.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/visit_repository.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'Pass/BookVisit/widgets/top_container.dart';
import 'package:keepapp/Pass/BookConference/widgets/BookConference_Screen.dart';

import 'Pass/src/login/widgets/login_screen.dart';

class HomePage_DashBoard extends StatefulWidget {
  final VisitRepository _visitRepository;
  final ConferenceRepository _conferenceRepository;
  final UserRepository _userRepository;
  final String _name;
  HomePage_DashBoard(
      {Key key,
      @required VisitRepository visitRepository,
      @required UserRepository userRepository,
      @required ConferenceRepository conferenceRepository,
      @required String name})
      : assert(visitRepository != null),
        assert(conferenceRepository != null),
        assert(userRepository != null),
        assert(name != null),
        _visitRepository = visitRepository,
        _conferenceRepository = conferenceRepository,
        _name = name,
        _userRepository = userRepository,
        super(key: key);
  @override
  _HomePage_DashBoardState createState() => _HomePage_DashBoardState();
}

class _HomePage_DashBoardState extends State<HomePage_DashBoard> {
  Device device;
  double width;
  VisitBloc visitBloc;
  int vActive, vcompleted;
  int cActive, cCompleted;
  VisitRepository get _visitRepository => widget._visitRepository;
  ConferenceRepository get _conferenceRepository =>
      widget._conferenceRepository;
  UserRepository get _userRepository => widget._userRepository;

  Text subheading(String title) {
    return Text(title,
        style: GoogleFonts.breeSerif(
            color: LightColors.kDarkBlue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2));
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
    visitBloc = Provider.of(context);
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading) {
          return CircularProgressIndicator();
        } else {
          for (int i = 0; i < 2; i++) {
            if (i == 0) {
              print("reach in visit");
              if (state is VisitStatsLoaded) {
                print("reach 1");
                vActive = state.numActive;
                vcompleted = state.numCompleted;
              }
            }
            if (i == 1) {
              print("reach in conference");
              if (state is ConferenceStatsLoaded) {
                print("reach 2");
                cActive = state.conference_numActive;
                cCompleted = state.conference_numCompleted;
                return Center(
                  child: bodyWidget(vActive, vcompleted, cActive, cCompleted),
                );
              }
            }
          }
        }
        return Container();
      },
    );
  }

  Widget bodyWidget(int vActive, int vComplted, int cActive, int cCompleted) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 200,
              width: width,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "My DashBoard",
                          style: GoogleFonts.lobster(
                              fontStyle: FontStyle.italic,
                              fontSize: 38,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert),
                          onSelected: (String result) {
                            _userRepository.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                        userRepository: _userRepository,
                                      )),
                            );
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'logout',
                              child: Text(
                                'Logout',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 90.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: LightColors.kRed,
                              backgroundColor: LightColors.kDarkYellow,
                              center: CircleAvatar(
                                backgroundColor: LightColors.kBlue,
                                radius: 35.0,
                                backgroundImage: AssetImage(
                                  'assets/images/avatar.png',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    widget._name,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.ubuntu(
                                        fontSize: device.deviceWidth / 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(
                                    'Visitor',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.creteRound(
                                        fontSize: device.deviceWidth / 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ///visit container
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Visit Records'),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            children: [
                              TaskColumn(
                                icon: Icons.blur_circular,
                                iconBackgroundColor: LightColors.kDarkYellow,
                                title: 'In Progress',
                                subtitle: vActive.toString(),
                              ),
                              SizedBox(
                                width: width / 6.7,
                              ),
                              TaskColumn(
                                icon: Icons.check_circle_outline,
                                iconBackgroundColor: LightColors.kBlue,
                                title: 'Completed',
                                subtitle: vComplted.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return FilteredVisit(
                                  visitRepository: _visitRepository,
                                );
                              }));
                            },
                            child: Container(
                              height: 80,
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Card(
                                shadowColor: Colors.deepOrange,
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'View All Your Visits',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.exo2(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 40.0),
                                      Material(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: LightColors.kDarkYellow,
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_forward_ios),
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 150, right: 150),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),

                    ///Conference container
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subheading('Conference Records'),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            children: [
                              TaskColumn(
                                icon: Icons.blur_circular,
                                iconBackgroundColor: LightColors.kDarkYellow,
                                title: 'In Progress',
                                subtitle: cActive.toString(),
                              ),
                              SizedBox(
                                width: width / 6.7,
                              ),
                              TaskColumn(
                                icon: Icons.check_circle_outline,
                                iconBackgroundColor: LightColors.kBlue,
                                title: 'Completed',
                                subtitle: cCompleted.toString(),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return FilteredConference(
                                  conferenceRepository: _conferenceRepository,
                                );
                              }));
                            },
                            child: Container(
                              height: 80,
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Card(
                                shadowColor: Colors.deepOrange,
                                elevation: 10.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'View All Your Conferences',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.exo2(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 40.0),
                                      Material(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: LightColors.kDarkYellow,
                                        child: IconButton(
                                          icon: Icon(Icons.arrow_forward_ios),
                                          color: Colors.blueAccent,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 150, right: 150),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          subheading('Our Services'),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  height: 150,
                                  width: device.deviceWidth / 2.3,
                                  child: GestureDetector(
                                    onTap: openBookVisitPage,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      color: Colors.orange.shade400,
                                      child: Center(
                                          child: Text("Book Visit",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.exo2(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  )),
                              Container(
                                  height: 150,
                                  width: device.deviceWidth / 2.3,
                                  child: GestureDetector(
                                    onTap: openBookConferncePage,
                                    child: Card(
                                      color: Colors.blueGrey.shade400,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Center(
                                        child: Text("Book Conference\nRoom",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.exo2(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openBookVisitPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => BookVisitScreen(
                visitRepository: _visitRepository,
              )),
    );
  }

  void openBookConferncePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => BookConferenceScreen(
                conferenceRepository: _conferenceRepository,
              )),
    );
  }
}
