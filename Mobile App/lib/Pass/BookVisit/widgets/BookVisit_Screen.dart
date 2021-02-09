import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Pass/BookVisit/widgets/BookVisit_form.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
class BookVisitScreen extends StatelessWidget {
  final VisitRepository _visitRepository;

  BookVisitScreen({Key key, @required VisitRepository visitRepository})
      : assert(visitRepository != null),
        _visitRepository = visitRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocProvider<VisitBloc>(
        create: (context) => VisitBloc(VisitRepository: _visitRepository),
          child: BookVisitForm(),

      ),
    );
  }
}
