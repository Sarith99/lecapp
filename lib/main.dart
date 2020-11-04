// ignore: avoid_web_libraries_in_flutter
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Lecture Schedules',
      home: HomePage(),
    ),
  );
}

List<Meeting> _getDataSource() {
  var meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

void _changeSchedule() {}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        //Added a hamburger menu.
        elevation: 20.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              //Retrieve user account information and display in the drawer header.
              accountName: Text("Sarith"),
              accountEmail: Text("nvskalhara.99@gmail.com"),
              currentAccountPicture: CircleAvatar(
                child: Text("Me"),
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              //First section of the hamburger menu, Home. It will navigate us to home page.
              leading: Icon(Icons.home),
              title: Text("Home"),
              //Directed to the home page
              onTap: () {
                print("Home Clicked");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              //Second section of the hamburger menu, Notifications.
              leading: Icon(Icons.notifications),
              title: Text("Notification"),
              //Directed to the notification page
              onTap: () {},
            ),
            ListTile(
              //3rd one,Settings.
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              //Directed to the Settings page
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        child: SfCalendar(
          view: CalendarView.day,
          dataSource: MeetingDataSource(_getDataSource()),
          timeSlotViewSettings: TimeSlotViewSettings(
            timelineAppointmentHeight: 100,
            timeIntervalHeight: 70,
            startHour: 8,
            endHour: 18,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeSchedule,
        tooltip: 'Change the time table',
        child: Icon(Icons.edit),
      ),
    );
  }
}

class ChangeSchedules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Schedule"),
      ),
    );
  }
}
