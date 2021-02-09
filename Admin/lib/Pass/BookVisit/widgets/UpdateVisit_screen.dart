import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookVisit/widgets/BookVisit_form.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:keepapp/Pass/BookVisit/widgets/UpdateVisit_form.dart';
class UpdateVisitScreen extends StatelessWidget {
  final VisitRepository _visitRepository;
  final Visit _visit;
  UpdateVisitScreen({Key key, @required VisitRepository visitRepository, @required Visit visit})
      : assert(visitRepository != null),assert(visit != null),
        _visitRepository = visitRepository,
        _visit= visit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider<VisitBloc>(
        create: (context) => VisitBloc(VisitRepository: _visitRepository),
        child: UpdateVisitForm(visit: _visit,),

      ),
    );
  }
}
