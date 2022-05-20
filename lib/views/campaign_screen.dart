import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tayal/themes/constant.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:tayal/views/dashboard_screen.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key key}) : super(key: key);

  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  bool _loading = false;
  StreamController<int> selected = StreamController<int>();
  //int selected = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  final items = <String>[
    '3 Lac + Silver Plate',
    '5 Lac + Samsung J7',
    '11 Lac + Gold coin',
    '18 Lac + Activa 5G',
    '30 Lac + Dubai Trip',
    '40 Lac + Alto 800',
    '60 Lac + Wagonr minor',
    '75 Lac + Swift Dzire',
    '1 Cr + Maruti Ciaz'
  ];

  var colors = [
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundShapeColor,
      body: ModalProgressHUD(
        color: Colors.indigo,
        inAsyncCall: _loading,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      _willPopCallback();
                    },
                    child: SvgPicture.asset('assets/images/back.svg',
                        fit: BoxFit.fill),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.12),
                  const Text("Campaign",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 21,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.zero,
                        height: size.height * 0.34,
                        width: size.width,
                        child: SfRadialGauge(
                            enableLoadingAnimation: true,
                            animationDuration: 2000,
                            axes: <RadialAxis>[
                              RadialAxis(
                                  minimum: 0,
                                  maximum: 90,
                                  startAngle: 180,
                                  canScaleToFit: true,
                                  endAngle: 0,
                                  labelsPosition: ElementsPosition.outside,
                                  showLabels: true,
                                  ranges: [
                                    GaugeRange(
                                      startValue: 0,
                                      endValue: 90,
                                      color: Colors.green,
                                      startWidth: 45,
                                      endWidth: 45,
                                      gradient: const SweepGradient(
                                          colors: <Color>[
                                            Color(0xFFFF7676),
                                            Color(0xFFF54EA2)
                                          ],
                                          stops: <double>[
                                            0.25,
                                            0.75
                                          ]),
                                    ),
                                  ],
                                  pointers: [
                                    NeedlePointer(
                                        animationDuration: 1000,
                                        enableAnimation: true,
                                        value: double.parse("40"),
                                        lengthUnit:
                                        GaugeSizeUnit.factor,
                                        needleLength: 0.7,
                                        needleEndWidth: 10,
                                        gradient:
                                        const LinearGradient(
                                            colors: <Color>[
                                              Colors.grey,
                                              Colors.grey,
                                              Colors.black,
                                              Colors.black
                                            ],
                                            stops: <double>[
                                              0,
                                              0.5,
                                              0.5,
                                              1
                                            ]),
                                        needleColor:
                                        const Color(0xFFF67280),
                                        knobStyle: const KnobStyle(
                                            knobRadius: 0.08,
                                            sizeUnit:
                                            GaugeSizeUnit.factor,
                                            color: Colors.black)),
                                  ],
                                  annotations: [
                                    const GaugeAnnotation(
                                        angle: 180,
                                        horizontalAlignment:
                                        GaugeAlignment.center,
                                        positionFactor: 0.8,
                                        verticalAlignment:
                                        GaugeAlignment.near,
                                        widget: Text(
                                          "0",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                        )),
                                    GaugeAnnotation(
                                        angle: 0,
                                        horizontalAlignment:
                                        GaugeAlignment.center,
                                        positionFactor: 0.8,
                                        verticalAlignment:
                                        GaugeAlignment.near,
                                        widget: Text(
                                          NumberFormat.compact().format(90),
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )),
                                  ])
                            ])),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                         height: 50,
                         width: double.infinity,
                         alignment: Alignment.center,
                         color: Colors.indigo,
                         child: const Text("FOR PRIZE DETAIL CLICK BELOW AREA",
                             textAlign: TextAlign.start,
                             style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w700,
                                 fontSize: 18)),
                              ),Image.asset('assets/images/down_arrow1.png', scale: 14,color: Colors.indigo)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selected.add(
                            Fortune.randomInt(0, items.length),
                          );
                        });
                      },
                      child: Container(
                        height: size.height * 0.35,
                        child: FortuneWheel(

                          physics: CircularPanPhysics(
                            duration: Duration(seconds: 1),
                            curve: Curves.decelerate,
                          ),
                          onFling: () {
                            selected.add(1);
                          },
                          /*indicators: const <FortuneIndicator>[
                            FortuneIndicator(
                              alignment: Alignment(0, -1.5),
                              child: TriangleIndicator(
                                color: Colors.indigo,
                              ),
                            ),
                          ],*/
                          indicators: [],
                          animateFirst: false,
                          selected: selected.stream,
                          items: const [
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.orange,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('3 Lac + Silver Plate', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.red,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('5 Lac + Samsung J7', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.indigo,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('11 Lac + Gold coin', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.orangeAccent,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('18 Lac + Activa 5G', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.blueAccent,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('30 Lac + Dubai Trip', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                            FortuneItem(
                                style: FortuneItemStyle(
                                  color: Colors.green,
                                  borderColor: Colors.white,
                                  borderWidth: 1,
                                ),
                                child: Text('40 Lac + Alto 800', textAlign: TextAlign.start, style: TextStyle(fontSize: 8)
                                )
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _willPopCallback() async {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
  }
}
