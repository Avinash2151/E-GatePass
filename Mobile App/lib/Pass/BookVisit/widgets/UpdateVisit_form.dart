import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepapp/widgets/DialogBox.dart';
import './MychipChoice.dart';
import './light_colors.dart';
import './back_button.dart';
import './my_text_field.dart';
import './top_container.dart';
import 'package:keepapp/Pass/BookVisit/bloc/Visit.dart';
import 'package:keepapp/Pass/BookVisit/visit_repository/lib/visit_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateVisitForm extends StatefulWidget {
  final Visit _visit;

  const UpdateVisitForm({Key key, @required Visit visit})
      : assert(visit != null),
        _visit = visit,
        super(key: key);
  @override
  State<StatefulWidget> createState() => _UpdateVisitFormState();
}

class _UpdateVisitFormState extends State<UpdateVisitForm> {
  DateTime _dateTime;
  String _dateToDisplay;
  String _timeToDisplay;

  int _date;
  int _time;
  int tag;
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

  TextEditingController nameController;
  TextEditingController addressController;
  TextEditingController dateTimeController;
  TextEditingController idproofController;
  TextEditingController purposeController;
  TextEditingController facilityController;
  TextEditingController mobileNoController;

  DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  VisitBloc _visitBloc;
  double width;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  void initState() {
    super.initState();
    _visitBloc = BlocProvider.of<VisitBloc>(context);
    nameController = TextEditingController(text: widget._visit.name);
    addressController = TextEditingController(text: widget._visit.address);
    dateTimeController =
        TextEditingController(text: widget._visit.dateTime.toString());
    idproofController =
        TextEditingController(text: widget._visit.idproof.toString());
    mobileNoController =
        TextEditingController(text: widget._visit.mob.toString());
    tag = widget._visit.purpose == "personal" ? 0 : 1;

    if (widget._visit.facility_1 == 'lunch' ||
        widget._visit.facility_2 == 'lunch' ||
        widget._visit.facility_3 == 'lunch') {
      print("reach 1");
      tags.add('lunch');
    }
    if (widget._visit.facility_1 == 'dinner' ||
        widget._visit.facility_2 == 'dinner' ||
        widget._visit.facility_3 == 'dinner') {
      print("reach 2");
      tags.add('dinner');
    }
    if (widget._visit.facility_1 == 'breakfast' ||
        widget._visit.facility_2 == 'breakfast' ||
        widget._visit.facility_3 == 'breakfast') {
      print("reach 3");
      tags.add('breakfast');
    }
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
    return BlocListener<VisitBloc, VisitState>(
      listener: (context, state) {},
      child: BlocBuilder<VisitBloc, VisitState>(
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
                          widget._visit.status == "req"
                              ? Text('Update / Delete visit',
                                  style: GoogleFonts.breeSerif(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700))
                              : Text('Visit Details',
                                  style: GoogleFonts.breeSerif(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w700)),
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
                            Text('Date : ' +
                                DateTime.fromMillisecondsSinceEpoch(
                                        widget._visit.dateTime)
                                    .toLocal()
                                    .toString()),
                            DateTimeField(
                              format: format,
                              onShowPicker: (context, currentValue) async {
                                final date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (date != null) {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        currentValue ?? DateTime.now()),
                                  );
                                  _dateTime = DateTimeField.combine(date, time);
                                  return DateTimeField.combine(date, time);
                                } else {
                                  return currentValue;
                                }
                              },
                            ),
                          ])
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
                              'Purpose of the Visit',
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
                      widget._visit.status == "req"
                          ? Column(
                              children: [
                                GestureDetector(
                                  onTap: _onFormSubmitted,
                                  child: Container(
                                    height: 80,
                                    width: width,
                                    child: Container(
                                      child: Text(
                                        'Update Visit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.fromLTRB(20, 10, 20, 20),
                                      width: width - 40,
                                      decoration: BoxDecoration(
                                        color: LightColors.kBlue,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 150, right: 150),
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: deleteData,
                                  child: Container(
                                    height: 80,
                                    width: width,
                                    child: Container(
                                      child: Text(
                                        'Delete Visit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.fromLTRB(20, 10, 20, 20),
                                      width: width - 40,
                                      decoration: BoxDecoration(
                                        color: LightColors.kBlue,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()
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

  void _onFormSubmitted() async {
    try {
      _visitBloc.add(
        UpdateVisit(Visit(
          doc_id: widget._visit.doc_id,
          status: widget._visit.status,
          id: mobileNoController.text,
          name: nameController.text,
          dateTime: _dateTime == null
              ? widget._visit.dateTime
              : _dateTime.millisecondsSinceEpoch,
          idproof: int.parse(idproofController.text),
          mob: int.parse(mobileNoController.text),
          address: addressController.text,
          purpose: tag == 1 ? 'industrial' : 'personal',
          //  tag.toString(),
          facility_1: tags.length >= 1 ? tags.first : "not needed",
          facility_2: tags.length >= 2 ? tags[1] : "not needed",
          facility_3: tags.length == 3 ? tags.last : "not needed",
        )),
      );
    } catch (Exception) {
      animated_dialog_box.showCustomAlertBox(
          context: context, yourWidget: Text("Enter valid fields"));
      print(Exception);
    }
  }

  void deleteData() async {
    try {
      _visitBloc.add(
        DeleteVisit(Visit(
          doc_id: widget._visit.doc_id,
          status: widget._visit.status,
          id: mobileNoController.text,
          name: nameController.text,
          dateTime: _dateTime == null
              ? widget._visit.dateTime
              : _dateTime.millisecondsSinceEpoch,
          idproof: int.parse(idproofController.text),
          mob: int.parse(mobileNoController.text),
          address: addressController.text,
          purpose: tag == 1 ? 'industrial' : 'personal',
          //  tag.toString(),
          facility_1: tags.length >= 1 ? tags.first : "not needed",
          facility_2: tags.length >= 2 ? tags[1] : "not needed",
          facility_3: tags.length == 3 ? tags.last : "not needed",
        )),
      );
    } catch (Exception) {
      animated_dialog_box.showCustomAlertBox(
          context: context, yourWidget: Text("Enter valid fields"));
      print(Exception);
    }
  }
}
