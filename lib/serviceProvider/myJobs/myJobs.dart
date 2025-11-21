import 'package:flutter/material.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/completedJobs.dart';
import 'package:flutter_loginregister/serviceProvider/myJobs/rejectedJobs.dart';
import 'acceptedJobs.dart';
import 'pendingJobs.dart';

class MyJobs extends StatefulWidget {
  static const routeName = '/ServiceProvider-jobs';
  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  int jobstate = 2;

  void toggleView(int choice) {
    setState(() => jobstate = choice);
  }

  @override
  Widget build(BuildContext context) {
    if (jobstate == 1) {
      return AcceptedJobsPage(toggleView: toggleView);
    } else if (jobstate == 2) {
      return PendingJobsPage(toggleView: toggleView);
    } else if (jobstate == 3) {
      return RejectedJobsPage(toggleView: toggleView);
    } else {
      return CompletedJobsPage(toggleView: toggleView);
    }
  }
}
