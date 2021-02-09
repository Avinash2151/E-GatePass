import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:keepapp/home_page.dart';
import 'blocs/filtered_visit/filtered_visit.dart';
import 'blocs/stats/stats_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'filtered_conference/filtered_conference_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: UserRepository())
                  ..add(AppStarted()),
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
                conferenceBloc: BlocProvider.of<ConferenceBloc>(context));
          }),
        ],
        child: MaterialApp(
            theme: ThemeData(
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
                      final name = state.displayName;
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<FilteredVisitBloc>(create: (context) {
                            return FilteredVisitBloc(
                              visitBloc: BlocProvider.of<VisitBloc>(context),
                            );
                          }),
                          BlocProvider<StatsBloc>(create: (context) {
                            return StatsBloc(
                                visitBloc: BlocProvider.of<VisitBloc>(context),
                                conferenceBloc:
                                    BlocProvider.of<ConferenceBloc>(context));
                          }),
                          BlocProvider<ConferenceBloc>(
                            create: (context) {
                              return ConferenceBloc(
                                ConferenceRepository:
                                    FirebaseConferenceRepository(),
                              )..add(Loadconference());
                            },
                          ),
                        ],
                        child: HomePage_DashBoard(
                          visitRepository: FirebaseVisitRepository(),
                          conferenceRepository: FirebaseConferenceRepository(),
                          userRepository: UserRepository(),
                          name: name,
                        ),
                      );
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
