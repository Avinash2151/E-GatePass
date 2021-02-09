import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/card_tile.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';

class PendingConferenceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferenceStatsBloc, ConferenceStatsState>(
      builder: (context, state) {
        if (state is ConferenceStatsLoaded) {
          final active = state.conferenceNumPending;
          return CardTile(
            iconBgColor: Colors.lightBlueAccent,
            cardTitle: 'Pending Conference',
            icon: Icons.show_chart,
            subText: "Upcomming",
            // "Today: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
            mainText: active.toString(),
          );
        }

        return Container();
      },
    );
  }
}
