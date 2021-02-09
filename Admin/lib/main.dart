import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Admin/Bloc/AddUserBloc/bloc.dart';
import 'package:keepapp/Employee/EmployeeDashboard.dart';
import 'package:keepapp/Employee/Widgets/Emp_Home_Page.dart';
import 'package:keepapp/Manager/ManagerDashBoard.dart';
import 'package:keepapp/Manager/Widgets/ManagerHomePage.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/src/firebase_conference_repository.dart';

import 'package:keepapp/Pass/src/auth/bloc/authentication_bloc.dart';
import 'package:keepapp/Pass/src/auth/bloc/authentication_event.dart';
import 'package:keepapp/Pass/src/auth/bloc/authentication_state.dart';
import 'package:keepapp/Pass/src/login/widgets/login_screen.dart';
import 'package:keepapp/Pass/src/simple_bloc_delegate.dart';
import 'package:keepapp/Pass/src/data/api/user_repository.dart';
import 'package:keepapp/Pass/src/widgets/splash_screen.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/src/firebase_visit_repository.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/RestartWidget.dart';
import 'package:keepapp/Security/SecurityDashBoard.dart';
import 'package:keepapp/Sr.Manager/Sr_ManagerDashBoard.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';
import 'package:keepapp/utils/Utils.dart';
import 'package:overlay_support/overlay_support.dart';
import 'Admin/ui/adminDashboard.dart';
import 'Security/SecurityCheckConferenceBloc/SecurityCheckConference.dart';
import 'Security/seccurityCheck_repository/lib/securityCheck_repository.dart';
import 'blocs/filtered_visit/filtered_visit.dart';
import 'blocs/stats/stats_bloc.dart';
import 'filtered_conference/filtered_conference_bloc.dart';
import 'package:keepapp/Security/SecurityCheckBloc/SecurityCheck.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: UserRepository())
                ..add(AppStarted()),
        ),
        BlocProvider<AddUserBloc>(
          create: (context) => AddUserBloc(userRepository: UserRepository()),
        ),
        BlocProvider<VisitBloc>(
          create: (context) {
            return VisitBloc(
              VisitRepository: FirebaseVisitRepository(),
            )..add(Loadvisit());
          },
        ),
        BlocProvider<ConferenceBloc>(
          create: (context) {
            return ConferenceBloc(
              ConferenceRepository: FirebaseConferenceRepository(),
            )..add(Loadconference());
          },
        ),
        BlocProvider<FilteredVisitBloc>(create: (context) {
          return FilteredVisitBloc(
            visitBloc: BlocProvider.of<VisitBloc>(context),
          );
        }),
        BlocProvider<FilteredConferenceBloc>(create: (context) {
          return FilteredConferenceBloc(
            conferenceBloc: BlocProvider.of<ConferenceBloc>(context),
          );
        }),
        BlocProvider<StatsBloc>(create: (context) {
          return StatsBloc(
            visitBloc: BlocProvider.of<VisitBloc>(context),
          );
        }),
        BlocProvider<ConferenceStatsBloc>(create: (context) {
          return ConferenceStatsBloc(
              conferenceBloc: BlocProvider.of<ConferenceBloc>(context));
        }),
        BlocProvider<SecurityCheckBloc>(create: (context) {
          return SecurityCheckBloc(
            securityCheckRepository: FirebaseSecurityCheckRepository(),
          )..add(DocIdCheck(""));
        }),
        BlocProvider<SecurityCheckConferenceBloc>(create: (context) {
          return SecurityCheckConferenceBloc(
            securityCheckConferenceRepository:
                FirebaseSecurityCheckConferenceRepository(),
          )..add(DocIdCheckConference(""));
        }),
      ],
      child: OverlaySupport(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              //primarySwatch: Colors.blue,
              //visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.light,
              primaryColor: Colors.lightBlueAccent,
              accentColor: Colors.lightBlueAccent,
            ),
            routes: {
              '/': (context) {
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Uninitialized) {
                      return SplashScreen();
                    }
                    if (state is Authenticated) {
                      print("reach in main Authenticated");
                      if (Utils.role == "Admin") {
                        return AdminDashboardWidget(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          securityCheckRepository:
                              FirebaseSecurityCheckRepository(),
                        );
                      } else if (Utils.role == "Sr.Manager") {
                        return SrManagerDashboardWidget(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          securityCheckRepository:
                              FirebaseSecurityCheckRepository(),
                        );
                      } else if (Utils.role == "Manager") {
                        return ManagerDashboardWidget(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          securityCheckRepository:
                              FirebaseSecurityCheckRepository(),
                        );
                      } else if (Utils.role == "Employee") {
                        return EmployeeDashboardWidget(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          securityCheckRepository:
                              FirebaseSecurityCheckRepository(),
                        );
                      } else if (Utils.role == "Security") {
                        return SecurityDashboardWidget(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          securityCheckRepository:
                              FirebaseSecurityCheckRepository(),
                        );
                      } else {
                        return Center(
                          child: Text("Role not selected"),
                        );
                      }
                    }

                    if (state is UnAuthenticated) {
                      return LoginScreen(
                        userRepository: UserRepository(),
                      );
                    }
                    return Container();
                  },
                );
              }
            }),
      ),
    );
  }
}
