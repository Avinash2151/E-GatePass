import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookConference/widgets/UpdateConferenceForm.dart';

class UpdateConferenceScreen extends StatelessWidget {
  final ConferenceRepository _conferenceRepository;
  final Conference _conference;
  UpdateConferenceScreen(
      {Key key,
      @required ConferenceRepository conferenceRepository,
      @required Conference conference})
      : assert(conferenceRepository != null),
        assert(conference != null),
        _conferenceRepository = conferenceRepository,
        _conference = conference,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ConferenceBloc>(
        create: (context) =>
            ConferenceBloc(ConferenceRepository: _conferenceRepository),
        child: UpdateConferenceForm(
          conference: _conference,
        ),
      ),
    );
  }
}
