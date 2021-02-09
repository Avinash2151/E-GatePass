import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/Pass/src/login/widgets/login_screen.dart';
import 'package:keepapp/Pass/src/simple_bloc_delegate.dart';
import 'package:keepapp/RestartWidget.dart';
import 'package:keepapp/Security/Widgets/Security_Conference_Home.dart';
import 'package:keepapp/Security/Widgets/Security_Visit_Home.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';
import 'package:keepapp/main.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:overlay_support/overlay_support.dart';

class SecurityDashboardWidget extends StatefulWidget {
  final VisitRepository _visitRepository;
  final ConferenceRepository _conferenceRepository;
  final UserRepository _userRepository;
  final SecurityCheckRepository _securityCheckRepository;

  SecurityDashboardWidget({
    Key key,
    @required VisitRepository visitRepository,
    @required UserRepository userRepository,
    @required ConferenceRepository conferenceRepository,
    @required SecurityCheckRepository securityCheckRepository,
  })  : assert(visitRepository != null),
        assert(conferenceRepository != null),
        assert(userRepository != null),
        assert(securityCheckRepository != null),
        _visitRepository = visitRepository,
        _conferenceRepository = conferenceRepository,
        _userRepository = userRepository,
        _securityCheckRepository = securityCheckRepository,
        super(key: key);
  @override
  _SecurityDashboardWidgetState createState() =>
      _SecurityDashboardWidgetState();
}

class _SecurityDashboardWidgetState extends State<SecurityDashboardWidget> {
  int _currentPage = 0;
  VisitRepository get _visitRepository => widget._visitRepository;
  ConferenceRepository get _conferenceRepository =>
      widget._conferenceRepository;
  SecurityCheckRepository get _securityCheckRepository =>
      widget._securityCheckRepository;
  OverlaySupport overlaySupport;
  UserRepository get _userRepository => widget._userRepository;
  final List<Widget> _pages = [
    SecurityHomePage(),
    SecurityConferenceHomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: Color(0xff2A3F54),
          width: 231,
          child: Drawer(
            child: Container(
              color: Color(0xff2A3F54),
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    //padding: EdgeInsets.zero,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              height: 30,
                              width: 50,
                            ),
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQoVxP6BSWt_Th-gPE1VK6416lx09HTdfHs0w&usqp=CAU",
                                  width: 70,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 15,
                            //   height: 100,
                            // ),
                            // Flexible(
                            //   child: Stack(
                            //     children: <Widget>[
                            //       // Row(
                            //       //   children: <Widget>[
                            //       //     SizedBox(
                            //       //       height: 48,
                            //       //     ),
                            //       //     Text(
                            //       //       Utils.userEmail,
                            //       //       softWrap: false,
                            //       //       style: TextStyle(
                            //       //           fontWeight: FontWeight.bold,
                            //       //           color: Color(0xffECF0F1)),
                            //       //     ),
                            //       //   ],
                            //       // ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(height: 13),
                        Text(
                          Utils.userEmail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffECF0F1)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          Utils.role,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffECF0F1)),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff2A3F54),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person_add,
                      color: Color(0xffE7E7E7),
                    ),
                    title: Text(
                      'Visit Entry',
                      style: TextStyle(
                        color: Color(0xffE7E7E7),
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentPage = 0;
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.group_work,
                      color: Color(0xffE7E7E7),
                    ),
                    title: Text(
                      'Conference Entry',
                      style: TextStyle(
                        color: Color(0xffE7E7E7),
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentPage = 1;
                      });
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.exit_to_app, color: Color(0xffE7E7E7)),
                    title: Text('Log Out',
                        style: TextStyle(
                          color: Color(0xffE7E7E7),
                          fontSize: 14,
                        )),
                    onTap: () {
                      _userRepository.signOut();
                      //RestartWidget.of(context).restartApp();
                      // SystemChannels.platform
                      //     .invokeMethod('SystemNavigator.pop');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(userRepository: UserRepository())),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Scaffold(
            body: _pages[_currentPage],
          ),
        ),
      ],
    );
  }

  mainbody() {
    WidgetsFlutterBinding.ensureInitialized();
    BlocSupervisor.delegate = SimpleBlocDelegate();
    runApp(
      RestartWidget(
        child: App(),
      ),
    );
  }
}
