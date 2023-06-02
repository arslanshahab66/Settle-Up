import 'package:flutter/material.dart';
import 'package:settle_up_expenses/View/GetbackPayment/payment.dart';
import 'package:settle_up_expenses/View/get_back_screen.dart';
import 'package:settle_up_expenses/View/owe_screen.dart';
import 'package:settle_up_expenses/View/total_balances.dart';
import 'package:settle_up_expenses/Widgets/decision_dialog.dart';
import '../Widgets/custom_drawer.dart';
import 'IOweToPayment.dart/i_owe_to.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: const Image(
                            height: 30,
                            image: AssetImage('assets/menu.png'),
                          ),
                        );
                      }),
                      const Spacer(), // Add Spacer widget to push the following widgets to the right side
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                showDecisionDialog(context, 'Do you want to:',
                                    () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GetBackFrom(),
                                    ),
                                  );
                                }, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const IOweToScreen(),
                                    ),
                                  );
                                });
                              },
                              child: const ClipOval(
                                child: Image(
                                  fit: BoxFit.contain,
                                  height: 20,
                                  image: AssetImage('assets/dollar_logo.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            backgroundColor: const Color(0xff5CAF9F),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TabBar(
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                        child: Text(
                      'Total Balances',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    )),
                    Tab(
                        child: Text(
                      'I Get Back',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    )),
                    Tab(
                        child: Text(
                      'I Owe',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
            // title: Text('Tabs Demo'),
          ),
          drawer: const CustomDrawer(),
          body: const TabBarView(
            children: [
              // Icon(Icons.flight, size: 350),

              TotalBalanceScreen(),
              GetBackScreen(),
              OweScreen(),
            ],
          ),
        ),
      ),
    );
  }
}



           // Padding(
              //   padding: const EdgeInsets.only(right: 5),
              //   child: Row(
              //     children: [
              //       Builder(builder: (context) {
              //         return GestureDetector(
              //             onTap: () {
              //               Scaffold.of(context).openDrawer();
              //             },
              //             child: const Image(
              //                 height: 30,
              //                 image: AssetImage('assets/menu.png')));
              //       }),
              //       Container(
              //         height: 30,
              //         width: 30,
              //         decoration: const BoxDecoration(
              //           color: Colors.white,
              //           shape: BoxShape
              //               .circle, // This sets the shape of the container to a circle
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(4.0),
              //           child: GestureDetector(
              //             onTap: () {
              //               showDecisionDialog(context, 'Do you want to:', () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             const GetBackFrom()));
              //               }, () {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             const IOweToScreen()));
              //               });
              //             },
              //             child: const ClipOval(
              //               child: Image(
              //                 fit: BoxFit.contain,
              //                 height: 20,
              //                 image: AssetImage('assets/dollar_logo.png'),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),


 