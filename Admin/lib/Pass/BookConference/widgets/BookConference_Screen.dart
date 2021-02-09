import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookConference/widgets/BookConference_form.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
class BookConferenceScreen extends StatelessWidget {
  final ConferenceRepository _conferenceRepository;

  BookConferenceScreen({Key key, @required ConferenceRepository conferenceRepository})
      : assert(conferenceRepository != null),
        _conferenceRepository = conferenceRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider<ConferenceBloc>(
        create: (context) => ConferenceBloc(ConferenceRepository: _conferenceRepository),
          child: BookConferenceForm(),

      ),
    );
  }
}
