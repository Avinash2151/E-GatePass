import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/Admin/widget/theme.dart';
import 'package:keepapp/Security/SecurityCheckConferenceBloc/SecurityCheckConference.dart';
import 'package:keepapp/seccurityCheck_Conference_repository/lib/securityCheck_Conference_repository.dart';
import 'package:keepapp/widgets/loading_indicator.dart';
import 'package:keepapp/widgets/DialogBox.dart';

class ConferenceForm extends StatefulWidget {
  final String _docId;

  const ConferenceForm({Key key, @required String docId})
      : assert(docId != null),
        _docId = docId,
        super(key: key);
  @override
  State<StatefulWidget> createState() => _ConferenceFormState();
}

class _ConferenceFormState extends State<ConferenceForm> {
  SecurityCheckConferenceBloc _securityCheckBloc;
  Image pickedImage;
  @override
  void initState() {
    _securityCheckBloc = BlocProvider.of<SecurityCheckConferenceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return BlocBuilder<SecurityCheckConferenceBloc,
        SecurityCheckConferenceState>(builder: (context, state) {
      if (state is SecurityCheckLoadingConference) {
        return LoadingIndicator();
      } else if (state is DocIDCheckLoadedConference) {
        final securityCheck = state.securityCheck;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 10,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: EdgeInsets.only(top: 2, left: 5, right: 5),
                height: _media.height / 1.6,
                width: _media.width / 3,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Conference Booking Details',
                            style: TextStyle(
                              color: Color(0xff2A3F54),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              // decorationColor: Color(0xff2A3F54)
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 5,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Conference Booking Id : " + securityCheck.doc_id,
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Name : " + securityCheck.name,
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Date : " +
                            DateFormat("dd-MM-yyyy").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    securityCheck.startTime)),
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Start Time : " +
                            DateFormat("hh : mm a").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    securityCheck.startTime)),
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "End Time : " +
                            DateFormat("hh : mm a").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    securityCheck.endTime)),
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Mobile No. : " + securityCheck.mob.toString(),
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Id Proof : " + securityCheck.idproof.toString(),
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Address : " + securityCheck.address,
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Facilities Want : ${securityCheck.facility_1 != "not needed" ? securityCheck.facility_1 : ""} \n                            ${securityCheck.facility_2 != "not needed" ? securityCheck.facility_2 : ""} \n                            ${securityCheck.facility_3 != "not needed" ? securityCheck.facility_3 : ""}",
                        style: cardTitleTextStyle,
                      ),
                      SizedBox(height: 15),
                      securityCheck.photoUrl ==
                              "https://vignette.wikia.nocookie.net/shokugekinosoma/images/6/60/No_Image_Available.png/revision/latest?cb=20171007175207"
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () => pickImage(),
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
                                      'Pick Image',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () =>
                                    showAlertImageView(securityCheck.photoUrl),
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
                                      'View Image',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Divider(
                        thickness: 5,
                      ),
                      securityCheck.entryTime == 0
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: () => _onFormSubmitted(),
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
                                      'Make Entry',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : securityCheck.exitTime == 0
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () => _onFormSubmitted_Exit(
                                        securityCheck.entryTime),
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
                                          'Make Exit',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 10,
              shadowColor: Colors.grey,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                height: _media.height / 4,
                width: _media.width / 3,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Data Not Found',
                            style: TextStyle(
                              color: Color(0xff2A3F54),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              // decorationColor: Color(0xff2A3F54)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  showAlertImageView(String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  child: SizedBox(
                        width: 800,
                        height: 500,
                        child: Image.network(image),
                      ) ??
                      Container(),
                ),
              ],
            ),
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

  showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  child: SizedBox(
                        width: 800,
                        height: 500,
                        child: pickedImage,
                      ) ??
                      Container(),
                ),
              ],
            ),
          ]),
          content: Text("Want To Upload this..."),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                // Api.upload(pickedImage);
                // _onFormSubmitted(entryTime, exitTime);

                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),
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

  pickImage() async {
    Image fromPicker =
        await ImagePickerWeb.getImage(outputType: ImageType.widget);

    if (fromPicker != null) {
      setState(() {
        pickedImage = fromPicker;
      });
    }
    showAlert();
  }

  void _onFormSubmitted() async {
    try {
      _securityCheckBloc.add(
        UpdateSecurityCheckConference(
          SecurityCheck_Conference(
            doc_id: widget._docId,
            status: "inProgress",
            entryTime: DateTime.now().millisecondsSinceEpoch,
            exitTime: 0,
          ),
        ),
      );
    } catch (Exception) {
      animated_dialog_box.showCustomAlertBox(
          context: context, yourWidget: Text("Enter valid fields"));
      print(Exception);
    }
  }

  void _onFormSubmitted_Exit(int entryTime) async {
    try {
      _securityCheckBloc.add(
        UpdateSecurityCheckConference(SecurityCheck_Conference(
            doc_id: widget._docId,
            status: "completed",
            entryTime: entryTime,
            exitTime: DateTime.now().millisecondsSinceEpoch)),
      );
    } catch (Exception) {
      animated_dialog_box.showCustomAlertBox(
          context: context, yourWidget: Text("Enter valid fields"));
      print(Exception);
    }
  }
}
