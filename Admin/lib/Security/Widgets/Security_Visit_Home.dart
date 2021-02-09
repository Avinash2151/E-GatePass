import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepapp/Admin/widget/theme.dart';
import 'package:keepapp/Security/SecurityCheckBloc/SecurityCheck.dart';
import 'package:keepapp/Security/Widgets/VisitForm.dart';
import 'package:keepapp/utils/Utils.dart';

import '../SecurityCheckBloc/SecurityCheck_bloc.dart';

class SecurityHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SecurityCheckBloc securityCheckBloc;

  TextEditingController visitid = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    securityCheckBloc = BlocProvider.of<SecurityCheckBloc>(context);
    print(_media);
    return Scaffold(
        body: Material(
      child: Center(
        child: body(_media, securityCheckBloc, context),
      ),
    ));
  }

  Widget body(
      var _media, SecurityCheckBloc securityCheckBloc, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: 10,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                height: _media.height / 3,
                width: _media.width / 3,
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Visit Entry',
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(height: 50),
                      Material(
                        elevation: 8.0,
                        shadowColor: Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        child: TextFormField(
                          controller: visitid,
                          decoration: InputDecoration(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.search,
                                    color: Color(0xff224597)),
                              ),
                              hintText: 'Enter Visit ID',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 15.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0))),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          onTap: () => checkEntry(context),
                          child: Material(
                            shadowColor: Colors.grey,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            color: Colors.greenAccent,
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 80,
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            VisitForm(
              docId: visitid.text,
            )
          ]),
          actions: <Widget>[
            FlatButton(
              child: Text("CANCEL"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  checkEntry(BuildContext context) {
    Utils.docID = visitid.text;
    securityCheckBloc.add(DocIdCheck(Utils.docID));
    showAlert(context);
    // openVisitFormPage(context);
  }

  openVisitFormPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => VisitForm(
                docId: visitid.text,
              )),
    );
  }
}
