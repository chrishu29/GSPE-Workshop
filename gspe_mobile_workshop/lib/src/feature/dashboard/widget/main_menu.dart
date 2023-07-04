import 'package:flutter/material.dart';
import 'package:gspe_mobile_workshop/src/feature/assets_workshop/assets_submenu.dart';
import 'package:gspe_mobile_workshop/src/feature/dashboard/widget/swiper_content.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/diagnosis_dashboard.dart';
import 'package:gspe_mobile_workshop/src/feature/diagnosis/diagnosis_entry.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/repairment.dart';
import 'package:gspe_mobile_workshop/src/feature/repairment/repairment_entry.dart';
import 'package:gspe_mobile_workshop/src/feature/reporting/reporting_subMenu.dart';
import 'package:gspe_mobile_workshop/src/feature/rma_customer/rma_dashboard.dart';
import 'package:gspe_mobile_workshop/src/feature/setup/setup_subMenu.dart';
import 'package:gspe_mobile_workshop/src/feature/transaction/transaction_subMenu.dart';
import 'package:provider/provider.dart';

class MainMenu {
  static GridView menu({required context}) {
    // final btnState = Provider.of<BtnState>(context, listen: false);
    bool btnState = false;
    return GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        //Diagnosis Entry
        GestureDetector(
            onTapDown: (_) {
              // btnState.isTap = true;
              btnState = true;
            },
            onTapUp: (_) {
              // btnState.isTap = false;
              btnState = false;
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const DiagnosisEntryDashboard()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            onTapCancel: () {
              // btnState.isTap = false;
              btnState = false;
            },
            child:
                // Consumer<BtnState>(builder: (context, btnState, _) {
                //   return
                AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(0, btnState ? 5 : 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color:
                            btnState == true ? Colors.white : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: btnState == true
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.filter_tilt_shift),
                          const SizedBox(height: 5),
                          Text(
                            'Diagnosis Entry',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
            // }),
            ),
        //Diagnosis Update
        GestureDetector(
            onTapDown: (_) {
              // btnState.isTap = true;
              btnState = true;
            },
            onTapUp: (_) {
              // btnState.isTap = false;
              btnState = false;
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const DiagnosisDashboard()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            onTapCancel: () {
              // btnState.isTap = false;
              btnState = false;
            },
            child:
                // Consumer<BtnState>(builder: (context, btnState, _) {
                //   return
                AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(0, btnState ? 5 : 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color:
                            btnState == true ? Colors.white : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: btnState == true
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.filter_tilt_shift_rounded),
                          const SizedBox(height: 5),
                          Text(
                            'Diagnosis Update',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
            // }),
            ),
        //Repairment Entry
        GestureDetector(
            onTapDown: (_) {
              // btnState.isTap = true;
              btnState = true;
            },
            onTapUp: (_) {
              // btnState.isTap = false;
              btnState = false;
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const RepairmentEntryDashboard()),
                  (Route<dynamic> route) => false,
                );
              });
            },
            onTapCancel: () {
              // btnState.isTap = false;
              btnState = false;
            },
            child:
                // Consumer<BtnState>(builder: (context, btnState, _) {
                //   return
                AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.translationValues(0, btnState ? 5 : 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color:
                            btnState == true ? Colors.white : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: btnState == true
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bug_report_outlined),
                          const SizedBox(height: 5),
                          Text(
                            'Repairment Entry',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
            // }),
            ),
        //Repairment Update
        GestureDetector(
          onTapDown: (_) {
            // btnState.isTap = true;
            btnState = true;
          },
          onTapUp: (_) {
            // btnState.isTap = false;
            btnState = false;
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const RepairmentDashboard()),
                (Route<dynamic> route) => false,
              );
            });
          },
          onTapCancel: () {
            // btnState.isTap = false;
            btnState = false;
          },
          child: 
          // Consumer<BtnState>(builder: (context, btnState, _) {
          //   return 
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform:
                  Matrix4.translationValues(0, btnState ? 5 : 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height / 8
                          : MediaQuery.of(context).size.width / 8,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        color:
                            btnState==true ? Colors.white : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: btnState==true
                            ? [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bug_report),
                          const SizedBox(height: 5),
                          Text(
                            'Repairment Update',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
          // }),
        ),
        //Diagnosis
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(
        //             builder: (context) => const DiagnosisDashboard()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.filter_tilt_shift_rounded),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Diagnosis',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // //RMA Customer
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => const RMADashboard()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.flag),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'RMA Customer',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // //Repairment
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(
        //             builder: (context) => const RepairmentDashboard()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.bug_report),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Repairment',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // //Asset
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => const AssetSubMenu()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.file_open_sharp),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Asset',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(
        //             builder: (context) => const TransactionSubMenu()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.area_chart_outlined),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Transaction',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(
        //             builder: (context) => const ReportingSubMenu()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.report_gmailerrorred_outlined),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Reporting',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // GestureDetector(
        //   onTap: () {},
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.height / 10,
        //         height: MediaQuery.of(context).size.height / 10,
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.transparent, width: 2),
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.circular(10),
        //           // boxShadow: [
        //           //   BoxShadow(
        //           //     color:
        //           //         Colors.transparent.withOpacity(0.3), // Shadow color
        //           //     spreadRadius: 5, // Spread radius
        //           //     blurRadius: 7, // Blur radius
        //           //     offset: Offset(0, 3), // Offset
        //           //   ),
        //           // ],
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             // Icon(Icons.menu),
        //             // const SizedBox(height: 5),
        //             // Text('Menu 7')
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // GestureDetector(
        //   onTapDown: (_) {
        //     btnState.isTap = true;
        //   },
        //   onTapUp: (_) {
        //     btnState.isTap = false;
        //     Future.delayed(const Duration(milliseconds: 200), () {
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => const SetupSubMenu()),
        //         (Route<dynamic> route) => false,
        //       );
        //     });
        //   },
        //   onTapCancel: () {
        //     btnState.isTap = false;
        //   },
        //   child: Consumer<BtnState>(builder: (context, btnState, _) {
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 200),
        //       curve: Curves.easeInOut,
        //       transform:
        //           Matrix4.translationValues(0, btnState.isTap ? 5 : 0, 0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AnimatedContainer(
        //               duration: Duration(milliseconds: 200),
        //               curve: Curves.easeInOut,
        //               width: MediaQuery.of(context).size.height / 10,
        //               height: MediaQuery.of(context).size.height / 10,
        //               decoration: BoxDecoration(
        //                 border: Border.all(color: Colors.black, width: 2),
        //                 color:
        //                     btnState.isTap ? Colors.white : Colors.blueAccent,
        //                 borderRadius: BorderRadius.circular(10),
        //                 boxShadow: btnState.isTap
        //                     ? [
        //                         BoxShadow(
        //                           color: Colors.grey.withOpacity(0.3),
        //                           spreadRadius: 5,
        //                           blurRadius: 7,
        //                           offset: Offset(0, 3),
        //                         ),
        //                       ]
        //                     : [],
        //               ),
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(Icons.settings),
        //                   const SizedBox(height: 5),
        //                   Text(
        //                     'Setup',
        //                     style: TextStyle(
        //                       fontSize: 15,
        //                     ),
        //                   )
        //                 ],
        //               )),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
        // GestureDetector(
        //   onTap: () {},
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         width: MediaQuery.of(context).size.height / 10,
        //         height: MediaQuery.of(context).size.height / 10,
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Colors.transparent, width: 2),
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.circular(10),
        //           // boxShadow: [
        //           //   BoxShadow(
        //           //     color:
        //           //         Colors.transparent.withOpacity(0.3), // Shadow color
        //           //     spreadRadius: 5, // Spread radius
        //           //     blurRadius: 7, // Blur radius
        //           //     offset: Offset(0, 3), // Offset
        //           //   ),
        //           // ],
        //         ),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             // Icon(Icons.menu),
        //             // const SizedBox(height: 5),
        //             // Text('Menu 9')
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  static Stack beautifulMenu({required context}) {
    return Stack(
      children: [
        //background
        Container(
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        ),
        //content
        Column(
          children: [
            //this is the menu list which is called from the above function
            Expanded(child: menu(context: context)),
            //you may add a footer widget here
            SizedBox(height: 100, child: SwiperContent.contentSwipe())
          ],
        ),
        //the top line decoration
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 10,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            const SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
