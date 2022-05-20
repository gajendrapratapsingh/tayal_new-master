import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayal/network/api.dart';
import 'package:tayal/themes/constant.dart';
import 'package:http/http.dart' as http;
import 'package:tayal/views/dashboard_screen.dart';
import 'package:tayal/views/order_detail_screen.dart';

class OrderlistScreen extends StatefulWidget {
  const OrderlistScreen({Key key}) : super(key: key);

  @override
  _OrderlistScreenState createState() => _OrderlistScreenState();
}

class _OrderlistScreenState extends State<OrderlistScreen> {

  List<dynamic> _orderlistdata = [];

  Future<List<dynamic>> _myorderlist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myorderlist = _getorderlist();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kBackgroundShapeColor,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                             Navigator.pop(context);
                          },
                          child: SvgPicture.asset('assets/images/back.svg', fit: BoxFit.fill),
                        ),
                        SizedBox(width: size.width * 0.17),
                        const Text("My Order", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.normal, fontSize: 21, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Expanded(
                        child: FutureBuilder(
                            future: _myorderlist,
                            builder: (context, snapshot){
                               if(snapshot.hasData){
                                 return ListView.builder(
                                     itemCount: snapshot.data.length,
                                     padding: EdgeInsets.zero,
                                     itemBuilder: (context, index){
                                         return Padding(
                                           padding: const EdgeInsets.all(10.0),
                                           child: InkWell(
                                             onTap: (){
                                               Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailScreen(
                                                 orderid : snapshot.data[index]['orderId'].toString(),
                                               )));
                                             },
                                             child: Container(
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text("order on ${snapshot.data[index]['order_date'].toString()}", style: TextStyle(color: Colors.grey, fontSize: 10)),
                                                   SizedBox(height: 10),
                                                   Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     children: [
                                                       snapshot.data[index]['item_count'].toString() == "1" ? Text("${snapshot.data[index]['item_count'].toString()} item", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)) : Text("${snapshot.data[index]['item_count'].toString()} items", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700)),
                                                       Text("\u20B9 ${snapshot.data[index]['amount'].toString()}", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400))
                                                     ],
                                                   ),
                                                   SizedBox(height: 5),
                                                   Text("order id : ${snapshot.data[index]['orderId'].toString()}", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300)),
                                                   SizedBox(height: 10),
                                                   Row(
                                                     children: [
                                                       Container(
                                                         height: 15,
                                                         width: 15,
                                                         decoration: const BoxDecoration(
                                                             color: Colors.indigo,
                                                             shape: BoxShape.circle
                                                         ),
                                                         child: Icon(Icons.check, color: Colors.white, size: 10),
                                                       ),
                                                       SizedBox(width: 7),
                                                       Text("${snapshot.data[index]['current_status'].toString()}", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300))
                                                     ],
                                                   ),
                                                   SizedBox(height: 10),
                                                   Container(
                                                     height: 45,
                                                     width: double.infinity,
                                                     alignment: Alignment.center,
                                                     decoration: BoxDecoration(
                                                         border: Border.all(color: Colors.indigo, width: 1),
                                                         borderRadius: BorderRadius.circular(10)
                                                     ),
                                                     child: Text("view details", style: TextStyle(color: Colors.indigo, fontSize: 12, fontWeight: FontWeight.w200)),
                                                   ),
                                                   SizedBox(height: 10),
                                                 ],
                                               ),
                                             ),
                                           ),
                                         );
                                     }
                                 );
                               }
                               else{
                                 return const Center(child: CircularProgressIndicator(color: Colors.indigo));
                               }
                            }
                        )
                    )
                  ],
                ),

              ),
            ],
          ),
        ),
        onWillPop: _willPopCallback
    );
  }

  Future<List<dynamic>> _getorderlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mytoken = prefs.getString('token').toString();
    var response = await http.post(Uri.parse(BASE_URL+orderlist),
        headers : {'Authorization': 'Bearer $mytoken'}
    );
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body)['Response'];
      return list;
      /*setState(() {
         _orderlistdata.addAll(list);
      });*/
    } else {
      throw Exception('Failed to get data due to ${response.body}');
    }
  }

  Future<bool> _willPopCallback() async {
    return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
  }
}
