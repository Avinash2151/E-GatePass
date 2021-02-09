import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/Pass/BookVisit/widgets/light_colors.dart';
import 'package:keepapp/blocs/blocs.dart';
import 'package:keepapp/widgets/widgets.dart';

class FilteredVisit extends StatelessWidget {
  final VisitRepository _visitRepository;
  FilteredVisit({Key key,@required VisitRepository visitRepository}) :
        assert(visitRepository != null),
        _visitRepository = visitRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredVisitBloc, FilteredVisitState>(
      builder: (context, state) {
        if (state is FilteredVisitLoading) {
          return LoadingIndicator();
        } else if (state is FilteredVisitLoaded) {
          final visits = state.filteredVisit;

          return Scaffold(
            backgroundColor: LightColors.kLightYellow,
            appBar: AppBar(
              title:  new Center(
                child: Text("My Visits",
                style: GoogleFonts.courgette(
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  return VisitCard(
                    visit: visit,
                    visitRepository: _visitRepository,
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
