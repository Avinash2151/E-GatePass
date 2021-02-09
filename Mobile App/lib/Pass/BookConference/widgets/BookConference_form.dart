import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/widgets/DialogBox.dart';
import 'package:keepapp/widgets/loading_indicator.dart';
import './MychipChoice.dart';
import './light_colors.dart';
import './back_button.dart';
import './my_text_field.dart';
import './top_container.dart';
import 'package:keepapp/Pass/BookConference/bloc/Conference.dart';
import 'package:keepapp/Pass/BookConference/conference_repository/lib/conference_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookConferenceForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookConferenceFormState();
}

class _BookConferenceFormState extends State<BookConferenceForm> {
  DateTime start_dateTime;
  DateTime end_dateTime;
  final format = DateFormat("yyyy-MM-dd HH:mm a");
  final time_format = DateFormat("HH:mm a");
  DateTime date;
  int tag = 1;
  List<String> options = [
    'Personal',
    'Inadustry',
  ];

  List<String> tags = [];
  List<String> options2 = [
    'lunch',
    'dinner',
    'breakfast',
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController idproofController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController facilityController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();

  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  ConferenceBloc _conferenceBloc;
  double width;

  @override
  void initState() {
    super.initState();
    _conferenceBloc = BlocProvider.of<ConferenceBloc>(context);
  }

  void dispose() {
    nameController.dispose();
    addressController.dispose();
    idproofController.dispose();
    purposeController.dispose();
    facilityController.dispose();
    mobileNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return BlocListener<ConferenceBloc, ConferenceState>(
      listener: (context, state) {},
      child: BlocBuilder<ConferenceBloc, ConferenceState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                TopContainer(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                  width: width,
                  child: Column(
                    children: <Widget>[
                      MyBackButton(),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Book a conference',
                              style: GoogleFonts.breeSerif(
                                  fontSize: 30.0, fontWeight: FontWeight.w700)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyTextField(
                            label: 'Full Name',
                            controller: nameController,
                          ),
                          Column(children: <Widget>[
                            Text('Select Date And start Time of visit'),
                            DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  start_dateTime =
                                      DateTimeField.combine(date, time);
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
                          ]),
                          Column(children: <Widget>[
                            Text('Select end Time of visit'),
                            DateTimeField(
                              format: time_format,
                              onShowPicker: (context, currentValue) async {
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  end_dateTime =
                                      DateTimeField.combine(date, time);
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
                          ]),
                        ],
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: MyTextField(
                              label: 'Mobile No',
                              controller: mobileNoController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        label: 'ID proof No.(e.g. Aadhar No)',
                        controller: idproofController,
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        label: 'Address',
                        controller: addressController,
                        minLines: 3,
                        maxLines: 3,
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Purpose of the Conference',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 10),
                            // ChipsChoice<T>.single
                            ChipsChoice<int>.single(
                              value: tag,
                              options: ChipsChoiceOption.listFrom<int, String>(
                                source: options,
                                value: (i, v) => i,
                                label: (i, v) => v,
                              ),
                              onChanged: (val) => setState(() => tag = val),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Select Hospital facility you want',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 10),
                            // ChipsChoice<T>.multiple
                            ChipsChoice<String>.multiple(
                              value: tags,
                              options:
                                  ChipsChoiceOption.listFrom<String, String>(
                                source: options2,
                                value: (i, v) => v,
                                label: (i, v) => v,
                              ),
                              onChanged: (val) => setState(() => tags = val),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: _onFormSubmitted,
                        child: Container(
                          height: 80,
                          width: width,
                          child: Container(
                            child: Text(
                              'Confirm Conference Room',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            width: width - 40,
                            decoration: BoxDecoration(
                              color: LightColors.kBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    try {
      _conferenceBloc.add(
        AddConference(
          Conference(
            status: "req",
            id: mobileNoController.text,
            name: nameController.text,
            startTime: start_dateTime.millisecondsSinceEpoch,
            endTime: end_dateTime.millisecondsSinceEpoch,
            idproof: int.parse(idproofController.text),
            mob: int.parse(mobileNoController.text),
            address: addressController.text,
            purpose: tag == 1 ? 'industrial' : 'personal',
            facility_1: tags.length >= 1 ? tags.first : "not needed",
            facility_2: tags.length >= 2 ? tags[1] : "not needed",
            facility_3: tags.length == 3 ? tags.last : "not needed",
          ),
        ),
      );

    } catch (Exception) {
      animated_dialog_box.showCustomAlertBox(
          context: context,
          yourWidget: Text("Please enter valid details"));
    }
  }
}
