import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/chart_card_tile.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';

class CompletedConferenceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferenceStatsBloc, ConferenceStatsState>(
      builder: (context, state) {
        if (state is ConferenceStatsLoaded) {
          final completed = state.conferenceNumCompleted;
          return ChartCardTile(
            cardColor: Color(0xFF25C6DA),
            cardTitle: 'Completed Conference',
            subText: " ",
            //"Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
            icon: Icons.pie_chart,
            typeText: completed.toString(),
          );
        }

        return Container();
      },
    );
  }
}
