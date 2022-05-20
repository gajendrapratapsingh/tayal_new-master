import 'package:flutter/material.dart';
class LedgerCalendarScreen extends StatefulWidget {
  const LedgerCalendarScreen({Key key}) : super(key: key);

  @override
  _LedgerCalendarScreenState createState() => _LedgerCalendarScreenState();
}

class _LedgerCalendarScreenState extends State<LedgerCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       body: Column(
         children: [
            Container(
              height: size.height * 0.50,
              width: double.infinity,
              color: Colors.red,
            ),
            Container(
             height: size.height * 0.50,
             width: double.infinity,
             color: Colors.green,
           ),
         ],
       )
    );
  }
}
