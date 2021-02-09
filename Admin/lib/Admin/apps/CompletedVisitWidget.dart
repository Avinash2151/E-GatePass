import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/chart_card_tile.dart';
import 'package:keepapp/blocs/stats/stats.dart';

class CompletedVisitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is VisitStatsLoaded) {
          final vcompleted = state.numCompleted;
          return ChartCardTile(
            cardColor: Color(0xFF7560ED),
            cardTitle: 'Completed Visit',
            subText: " ",
            //"Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
            icon: Icons.pie_chart,
            typeText: vcompleted.toString(),
          );
        }

        return Container();
      },
    );
  }
}
