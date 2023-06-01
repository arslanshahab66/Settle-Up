
import 'package:flutter/material.dart';

import 'package:settle_up_expenses/Widgets/dialog_box_widget.dart';
import '../Widgets/reuseable_imagelist_tile.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Friend'),
          backgroundColor: const Color(0xff5CAF9F),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 270,
                      height: 30, // Set the height of the container
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
                        borderRadius: BorderRadius.circular(20),
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Add this contact to splitwise?',
                        hintText: 'Enter Number',
                        onAdd: (value) {
                          // handle add logic
                        },
                        onEdit: (value) {
                          // handle edit logic
                        },
                      );
                    },
                  );
                },
                child: const ImageListTile(
                    imageUrl: 'assets/Lucy_stark.png', title: 'Lucy Stark'),
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Add this contact to splitwise?',
                          hintText: 'Enter Number',
                          onAdd: (value) {
                            // handle add logic
                          },
                          onEdit: (value) {
                            // handle edit logic
                          },
                        );
                      },
                    );
                  },
                  child: const ImageListTile(
                      imageUrl: 'assets/alec.png', title: 'Alec')),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Add this contact to splitwise?',
                          hintText: 'Enter Number',
                          onAdd: (value) {
                            // handle add logic
                          },
                          onEdit: (value) {
                            // handle edit logic
                          },
                        );
                      },
                    );
                  },
                  child: const ImageListTile(
                      imageUrl: 'assets/nancy.png', title: 'Nancy')),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Add this contact to splitwise?',
                        hintText: 'Enter Number',
                        onAdd: (value) {
                          // handle add logic
                        },
                        onEdit: (value) {
                          // handle edit logic
                        },
                      );
                    },
                  );
                },
                child: const ImageListTile(
                    imageUrl: 'assets/profile_2.png', title: 'Michael James'),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        title: 'Add this contact to splitwise?',
                        hintText: 'Enter Number',
                        onAdd: (value) {
                          // handle add logic
                        },
                        onEdit: (value) {
                          // handle edit logic
                        },
                      );
                    },
                  );
                },
                child: const ImageListTile(
                    imageUrl: 'assets/miss_clarke.png', title: 'Miss Clarke'),
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                          title: 'Add this contact to splitwise?',
                          hintText: 'Enter Number',
                          onAdd: (value) {
                            // handle add logic
                          },
                          onEdit: (value) {
                            // handle edit logic
                          },
                        );
                      },
                    );
                  },
                  child: const ImageListTile(
                      imageUrl: 'assets/chase.png', title: 'Chase')),
              const ImageListTile(
                  imageUrl: 'assets/Lucy_stark.png', title: 'Lucy Stark'),
              const ImageListTile(
                  imageUrl: 'assets/Lucy_stark.png', title: 'Lucy Stark'),
              const ImageListTile(
                  imageUrl: 'assets/Lucy_stark.png', title: 'Lucy Stark'),
            ],
          ),
        ),
      ),
    );
  }


}
