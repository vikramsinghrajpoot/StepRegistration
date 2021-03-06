import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registration/Modules/CommonViews/AppDatePicker.dart';
import 'package:registration/Modules/CommonViews/AppTimePicker.dart';
import 'package:registration/Modules/CommonViews/ProgressBar.dart';
import 'package:registration/Modules/CommonViews/StepTitle.dart';
import 'package:registration/Modules/Meeting/Widgets/CalendarIcon.dart';
import 'package:registration/Modules/PersonalInfo/Widgets/DateTimeButton.dart';
import 'package:registration/Modules/Welcome/Widgets/NextButton.dart';

class MeetingInfo extends StatefulWidget {
  const MeetingInfo({Key key}) : super(key: key);

  @override
  _MeetingInfoState createState() => _MeetingInfoState();
}

class _MeetingInfoState extends State<MeetingInfo> {
  String selectedDate;
  String selectedTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          margin: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProgresBar(
                currentIndex: 3,
              ),
              Container(
                child: CalendarIcon(),
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              StepTitle(
                title: "Schedule Video Call",
                subTitle:
                    "Choose the date and time that you preffered. We will send a link by email to make a video call on the scheduled date and time",
              ),
              SizedBox(
                height: 30,
              ),
              DateTimeButton(
                hintText: "Date",
                value: selectedDate ?? "- Choose Date -",
                onPressed: Platform.isIOS
                    ? this._showiOSDatePicker
                    : this._showAndroidDatePicker,
              ),
              SizedBox(
                height: 30,
              ),
              DateTimeButton(
                hintText: "Time",
                value: this.selectedTime == null
                    ? "- Choose Date -"
                    : this.selectedTime.toString(),
                onPressed: this._showTimePicker,
              ),
              Spacer(),
              NextButton(
                height: 100,
                onPressed: this._nextPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextPressed(context) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => PersonalInfo()));
  }

  _showiOSDatePicker(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 270,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Text("Date Picker"),
                    AppDatePicker(
                      selectedDate: (_selectedDate) {
                        this.setState(() {
                          this.selectedDate = _selectedDate;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  _showTimePicker(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 270,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Text("Date Picker"),
                    AppTimePicker(
                      timeDidSelected: (_time) {
                        this.setState(() {
                          this.selectedTime = format(_time);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  _showAndroidDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null)
      setState(() {
        DateFormat dateFormat = DateFormat("dd-MMM-yyyy");
        selectedDate = dateFormat.format(picked);
      });
  }

  format(Duration d) => d.toString().substring(2, 7);
}
