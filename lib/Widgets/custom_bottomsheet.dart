import 'package:flutter/material.dart';

import 'package:settle_up_expenses/View/add_bill_screen.dart';
import 'package:settle_up_expenses/View/all_payments.dart';
import 'package:settle_up_expenses/View/contact_list.dart';
import 'package:settle_up_expenses/View/contacts_helper.dart';
import '../View/create_group_screen.dart';

class CustomBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1000),
        ),
      ),
      builder: (BuildContext context) {
        return _buildBottomSheetContent(context);
      },
    );
  }

  static Widget _buildBottomSheetContent(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.5,
      decoration: BoxDecoration(
        color: Color(0xffABDDD3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(screenWidth * 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    ContactsHelper.getContactsPermission(context).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactsList()));
                    });
                  },
                  child: Container(
                    height: 28,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            ContactsHelper.getContactsPermission(context)
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactsList()));
                            });
                          },
                          child: const Text(
                            'Add Friend',
                            style: TextStyle(
                              color: Color(0xff5CAF9F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ContactsHelper.getContactsPermission(context).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactsList()));
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/person.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllPaymentsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 28,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'All Payments',
                          style: TextStyle(
                            color: Color(0xff5CAF9F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ContactsHelper.getContactsPermission(context).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllPaymentsScreen()));
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/group.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddBillScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 28,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          'Add Bill',
                          style: TextStyle(
                            color: Color(0xff5CAF9F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    ContactsHelper.getContactsPermission(context).then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddBillScreen()));
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff5CAF9F),
                        width: 1.5,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/signature.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xff5CAF9F),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Image(
                        height: 25,
                        width: 25,
                        image: AssetImage('assets/cross.png'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
