import 'package:flutter/material.dart';

/// This widget acts as a tile button for the homepage screen. Where other
/// widgets can be displayed in.
enum Status { New, Accepted, Rejected }

class StatusWidget extends StatelessWidget {

  Status status;

  StatusWidget(this.status);

  //TODO: add ontap-function, all tiles have a different screen to navigate to

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: CircleAvatar(
        backgroundColor: _statusColor(this.status),
        radius: height / 30,
        child: _statusIcon(this.status, height),
      ),
    );
  }

  // ignore: missing_return
  Color _statusColor(Status s) {
    switch(s) {
      case Status.New:
        return Colors.grey;
        break;
      case Status.Accepted:
        return Colors.green;
        break;
      case Status.Rejected:
        return Colors.red;
        break;
    }
  }

  // ignore: missing_return
  Widget _statusIcon(Status s, double height) {
    switch(s) {
      case Status.New:
        return Text('?', style: TextStyle(fontSize: height / 25, color: Colors.black54, fontFamily: 'default', fontWeight: FontWeight.bold));
        break;
      case Status.Accepted:
        return Icon(Icons.check, size: height / 25);
        break;
      case Status.Rejected:
        return Icon(Icons.not_interested, size: height / 25);
        break;
    }
  }

}