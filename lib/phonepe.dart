import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePeScreen extends StatefulWidget {
  const PhonePeScreen({super.key});

  @override
  State<PhonePeScreen> createState() => _PhonePeScreenState();
}

class _PhonePeScreenState extends State<PhonePeScreen> {
  String result = '';
  @override
  void initState() {
    PhonePePaymentSdk.init('SANDBOX', '', '90223250', true).then((value) {
      print('The value is $value');
    });
    super.initState();
  }

  void startTransaction() async {
    try {
      PhonePePaymentSdk.startTransaction(
        'ewogICJtZXJjaGFudElkIjogIlBHVEVTVFBBWVVBVCIsCiAgIm1lcmNoYW50VHJhbnNhY3Rpb25JZCI6ICJNVDc4NTA1OTAwNjgxODgxMDQiLAogICJtZXJjaGFudFVzZXJJZCI6ICJNVUlEMTIzIiwKICAiYW1vdW50IjogMTAwMDAsCiAgInJlZGlyZWN0VXJsIjogImh0dHBzOi8vd2ViaG9vay5zaXRlL3JlZGlyZWN0LXVybCIsCiAgInJlZGlyZWN0TW9kZSI6ICJSRURJUkVDVCIsCiAgImNhbGxiYWNrVXJsIjogImh0dHBzOi8vd2ViaG9vay5zaXRlL2NhbGxiYWNrLXVybCIsCiAgIm1vYmlsZU51bWJlciI6ICI5OTk5OTk5OTk5IiwKICAicGF5bWVudEluc3RydW1lbnQiOiB7CiAgICAidHlwZSI6ICJQQVlfUEFHRSIKICB9Cn0',
        '',
        'd7a8e4458caa6fcd781166bbdc85fec76740c18cb9baa9a4c48cf2387d554180###1',
        'My app',
      )
          .then((response) => {
                setState(() {
                  if (response != null) {
                    String status = response['status'].toString();
                    String error = response['error'].toString();
                    if (status == 'SUCCESS') {
                      result = "Flow Completed - Status: Success!";
                    } else {
                      result =
                          "Flow Completed - Status: $status and Error: $error";
                    }
                  } else {
                    result = "Flow Incomplete";
                  }
                })
              })
          .catchError((error) {
        print(error.toString());
        return <dynamic>{};
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: Text('PhonePe screen'),
            ),
          ),
          GestureDetector(
            onTap: () {
              startTransaction();
            },
            child: Container(
              color: Colors.blueAccent,
              height: 30,
              width: 60,
              child: Center(
                child: Text('Pay'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
