import 'package:flutter/material.dart';

import '../Widgets/create_group_button.dart';
import '../Widgets/reuseable_container.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
        centerTitle: true,
        backgroundColor: const Color(0xff5CAF9F),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter group name',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffC1C5C8),
                            )),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffC1C5C8),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Add friends to group',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffC1C5C8),
                            )),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffC1C5C8),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Select categories',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Color(0xffC1C5C8),
                            )),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xffC1C5C8),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                    
                          child: const CustomCircleIcon(
                            color: Color(0xffF35E5E),
                            image: 'assets/planee.png',
                            text: 'Plane',
                          ),
                        ),
                        const CustomCircleIcon(
                          color: Color(0xff455EDF),
                          image: 'assets/cutlery (1) 1.png',
                          text: 'Restaurant',
                        ),
                        const CustomCircleIcon(
                          color: Color(0xffAB73AC),
                          image: 'assets/car 1.png',
                          text: 'Car',
                        ),
                        const CustomCircleIcon(
                          color: Color(0xffCCC400),
                          image: 'assets/game-controller 1.png',
                          text: 'Games',
                        ),
                        const CustomCircleIcon(
                          color: Color(0xff82E07A),
                          image: 'assets/fuel 1.png',
                          text: 'Fuel',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  [
                        CustomCircleIcon(
                          color: Color(0xffFFA722),
                          image: 'assets/rent.png',
                          text: 'Rent',
                        ),
                        CustomCircleIcon(
                          color: Color(0xff21DFDF),
                          image: 'assets/movie.png',
                          text: 'Movie',
                        ),
                        CustomCircleIcon(
                          color: Color(0xff581463),
                          image: 'assets/gas.png',
                          text: 'Gas',
                        ),
                        CustomCircleIcon(
                          color: Color(0xff4B8512),
                          image: 'assets/trip.png',
                          text: 'Trip',
                        ),
                        CustomCircleIcon(
                          color: Color(0xffEFEB92),
                          image: 'assets/other.png',
                          text: 'Other',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const GetBackFrom()));
                // },
                child: reusebaleCreateGroupButton('Create Group', context)),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 90,
              width: MediaQuery.of(context).size.width * 1,
              decoration: const BoxDecoration(
                color: Color(0xffEDEFEE),
              ),
              child: const Padding(
                padding:  EdgeInsets.only(top: 10, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'Advance Setting',
                      style: TextStyle(
                        color: Color(0xff5CAF9F),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Simplify debts is on',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Learn more',
                      style: TextStyle(fontSize: 10, color: Color(0xffC1C5C8)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
