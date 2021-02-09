import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/card_tile.dart';
import 'package:keepapp/blocs/stats/stats.dart';

class ActiveVisitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsBloc, StatsState>(
      builder: (context, state) {
        if (state is VisitStatsLoaded) {
          final active = state.numActive;
          return CardTile(
            iconBgColor: Colors.orange,
            cardTitle: 'Active Visits',
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
