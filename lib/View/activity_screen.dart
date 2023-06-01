import 'package:flutter/material.dart';
import '../Widgets/activity_listtile_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffD9D9D9),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.34,
                width: double.infinity,
                color: const Color(0xff5CAF9F),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Image(
                              height: 30,
                              width: 30,
                              image: AssetImage('assets/menu.png')),
                          Container(
                            width: 270,
                            height: 30, // Set the height of the container
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Color(
                                      0xff5CAF9F), // This sets the color of the hint text to green
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xff5CAF9F),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal:
                                        10), // Set the padding of the text field
                              ),
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff5CAF9F),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape
                                  .circle, // This sets the shape of the container to a circle
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: ClipOval(
                                child: Image(
                                  fit: BoxFit.contain,
                                  height: 20,
                                  image: AssetImage('assets/dollar_logo.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 35, horizontal: 15),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  child: const Row(
                                    children:  [
                                      Image(
                                          image: AssetImage(
                                              'assets/Lucy_stark.png')),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'Lucy Stark',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          '\$ 15',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'I get Back',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          height: 31,
                                          width: 95,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Settle up',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff5CAF9F)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Row(
                      children:  [
                        Text(
                          'Activity',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffC1C5C8)),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 4.0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xffD9D9D9),
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: const SingleChildScrollView(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children:  [
                                  CustomListTile(
                                    color: Color(0xff4B8512),
                                    leadingImagePath: 'assets/trip.png',
                                    title: 'Trip to Museum',
                                    subtitle1: 'You Nancy, Alec & 3 more',
                                    trailingIconPath:
                                        'assets/arrow_downward.png',
                                    trailingText: '15 \$',
                                    trailingSubtext: 'I get back',
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xffD9D9D9),
                                  ),
                                  CustomListTile(
                                    color: Color(0xff455EDF),
                                    leadingImagePath:
                                        'assets/cutlery (1) 1.png',
                                    title: 'Saturday Dinner',
                                    subtitle1: 'You Nancy, Alec & 3 more',
                                    trailingIconPath:
                                        'assets/arrow_downward.png',
                                    trailingText: '15 \$',
                                    trailingSubtext: 'I get back',
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xffD9D9D9),
                                  ),
                                  CustomListTile(
                                    color: Color(0xff21DFDF),
                                    leadingImagePath: 'assets/movie.png',
                                    title: 'Watching Movie',
                                    subtitle1: 'You Nancy, Alec & 3 more',
                                    trailingIconPath:
                                        'assets/arrow_downward.png',
                                    trailingText: '15 \$',
                                    trailingSubtext: 'I get back',
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xffD9D9D9),
                                  ),
                                  CustomListTile(
                                    color: Color(0xffFFA722),
                                    leadingImagePath: 'assets/rent.png',
                                    title: 'House Rent',
                                    subtitle1: 'You Nancy, Alec & 3 more',
                                    trailingIconPath:
                                        'assets/arrow_downward.png',
                                    trailingText: '15 \$',
                                    trailingSubtext: 'I get back',
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0xffD9D9D9),
                                  ),
                                  CustomListTile(
                                    color: Color(0xffCCC400),
                                    leadingImagePath:
                                        'assets/game-controller 1.png',
                                    title: 'Avengers Endgame',
                                    subtitle1: 'You Nancy, Alec & 3 more',
                                    trailingIconPath:
                                        'assets/arrow_downward.png',
                                    trailingText: '15 \$',
                                    trailingSubtext: 'I get back',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
