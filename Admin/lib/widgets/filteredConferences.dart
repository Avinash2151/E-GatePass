import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/src/conference_repository.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:keepapp/Pass/BookConference/widgets/light_colors.dart';
import 'package:keepapp/filtered_conference/filtered_conference.dart';
import 'package:keepapp/widgets/conference_card.dart';
import 'package:keepapp/widgets/widgets.dart';

class FilteredConference extends StatelessWidget {
  final ConferenceRepository _conferenceRepository;
  FilteredConference(
      {Key key, @required ConferenceRepository conferenceRepository})
      : assert(conferenceRepository != null),
        _conferenceRepository = conferenceRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredConferenceBloc, FilteredConferenceState>(
      builder: (context, state) {
        if (state is FilteredConferenceLoading) {
          return LoadingIndicator();
        } else if (state is FilteredConferenceLoaded) {
          final conferences = state.filteredConference;

          return Scaffold(
            backgroundColor: LightColors.kLightYellow,
            appBar: AppBar(
              title: new Center(
                child: Text("My Conferences",
                    style: TextStyle(
                        fontFamily: 'Courgette',
                        fontStyle: FontStyle.normal,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)

                    // GoogleFonts.courgette(
                    //     fontStyle: FontStyle.normal,
                    //     fontSize: 25,
                    //     fontWeight: FontWeight.bold),
                    ),
              ),
              backgroundColor: LightColors.kDarkYellow,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: FilterButton(),
                ),
              ],
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: conferences.length,
                itemBuilder: (context, index) {
                  final conference = conferences[index];
                  return ConferenceCard(
                    conference: conference,
                    conferenceRepository: _conferenceRepository,
                  );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
