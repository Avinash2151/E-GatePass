import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/card_tile.dart';
import 'package:keepapp/blocs/ConferenceStats/conferenceStats.dart';

class ActiveConferenceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConferenceStatsBloc, ConferenceStatsState>(
      builder: (context, state) {
        if (state is ConferenceStatsLoaded) {
          final active = state.conferenceNumActive;
          return CardTile(
            iconBgColor: Colors.pinkAccent,
            cardTitle: 'Active Conference',
            icon: Icons.show_chart,
            subText:
                "Today: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
            mainText: active.toString(),
          );
        }

        return Container();
      },
    );
  }
}
