import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Security/Widgets/Security_Visit_Home.dart';
import 'package:keepapp/Security/seccurityCheck_repository/lib/securityCheck_repository.dart';

import '../SecurityCheckBloc/SecurityCheck_bloc.dart';

class SecurityHomeScreen extends StatelessWidget {
  final FirebaseSecurityCheckRepository _firebaseSecurityCheckRepository;

  SecurityHomeScreen(
      {Key key,
      @required
          FirebaseSecurityCheckRepository firebaseSecurityCheckRepository})
      : assert(firebaseSecurityCheckRepository != null),
        _firebaseSecurityCheckRepository = firebaseSecurityCheckRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<SecurityCheckBloc>(
        create: (context) => SecurityCheckBloc(
          securityCheckRepository: FirebaseSecurityCheckRepository(),
        ),
        child: SecurityHomePage(),
      ),
    );
  }
}
