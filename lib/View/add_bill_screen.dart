import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:settle_up_expenses/View/tab_bar.dart';
import 'package:settle_up_expenses/Widgets/avatar_widget.dart';
import '../Widgets/create_group_button.dart';
import '../Widgets/dropdown_widget.dart';
import '../Widgets/reuseable_container.dart';
import 'GetbackPayment/get_back_contact_helper.dart';
import 'contact_list.dart';

class AddBillScreen extends StatefulWidget {
  final List<Contact>? selectedContacts;

  const AddBillScreen({Key? key, this.selectedContacts}) : super(key: key);

  @override
  State<AddBillScreen> createState() => _AddBillScreenState();
}

class _AddBillScreenState extends State<AddBillScreen> {
  TextEditingController _selectedDateTime = TextEditingController();
  DateTime? selectedDate;
  DateTime? _pickedDate;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();

  String selectedCategoryImage = 'assets/planee.png';
  bool isCategorySelected = false;

  @override
  void initState() {
    super.initState();
    if (selectedDate != null) {
      _selectedDateTime.text = formatDateToDaysAgo(selectedDate!);
    } else {
      _selectedDateTime.text = 'Dates';
    }
  }

  String? selectedValue;
  String? selectedContactValue;

  bool _validateInputs() {
    if (widget.selectedContacts == null || widget.selectedContacts!.isEmpty) {
      _showWarningDialog(
          'No Contacts Selected', 'Please select at least one contact.');
      return false;
    }

    if (descriptionController.text.isEmpty) {
      _showWarningDialog('Description Required', 'Please enter a description.');
      return false;
    }

    if (amountController.text.isEmpty) {
      _showWarningDialog('Amount Required', 'Please enter the amount.');
      return false;
    }

    if (categoriesController.text.isEmpty) {
      _showWarningDialog('Category Required', 'Please select a category.');
      return false;
    }

    if (selectedContactValue == null || selectedContactValue!.isEmpty) {
      _showWarningDialog(
          'Paid By Required', 'Please select a contact as "Paid By".');
      return false;
    }

    if (selectedValue == null || selectedValue!.isEmpty) {
      _showWarningDialog(
          'Split By Required', 'Please select a contact as "Split By".');
      return false;
    }

    if (selectedDate == null) {
      _showWarningDialog('Date Required', 'Please select a date.');
      return false;
    }

    return true;
  }

  void _showWarningDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff5CAF9F),
        title: const Text('Add Bill'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  ContactsHelper.getContactsPermission(context).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsList()));
                  });
                },
                child: Container(
                  height: 35,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white, // Set the container color to white
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(
                          0xff5CAF9F), // Set the border color to green
                      width: 1.0,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Select contacts',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.selectedContacts != null
                        ? widget.selectedContacts!.length
                        : 0,
                    itemBuilder: (context, index) {
                      Contact contact = widget.selectedContacts![index];
                      String displayName = contact.displayName ?? '';
                      String phoneNumber = contact.phones!.isNotEmpty
                          ? contact.phones!.first.value ?? ''
                          : '';
                      var avatar = contact.avatar;
                      var avatarWidget = avatar != null && avatar.length > 0
                          ? CircleAvatar(
                              backgroundColor: const Color(0xff5CAF9F),
                              backgroundImage: MemoryImage(avatar),
                            )
                          : CircleAvatar(
                              backgroundColor: const Color(0xff5CAF9F),
                              child: Text(
                                displayName.isNotEmpty
                                    ? displayName[0].toUpperCase()
                                    : '',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xff5CAF9F),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children: [
                                    CircleAvatarWithInitial(
                                        displayName: contact.displayName ?? ''),
                                    const SizedBox(width: 8.0),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        contact.displayName ?? '',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Transform.translate(
                                offset: const Offset(8, -8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.selectedContacts!.removeAt(index);
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Color(0xff5CAF9F),
                                    child: Image(
                                      height: 10,
                                      image: AssetImage('assets/cross.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Container(
                    height: 65,
                    width: 45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xff5CAF9F), width: 1),
                      color: isCategorySelected
                          ? const Color(0xff5CAF9F)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image(image: AssetImage(selectedCategoryImage)),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                              hintText: 'Enter A description',
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
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Enter Amount',
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
                      Container(
                        height: 50,
                        width: 200,
                        child: TextFormField(
                          controller: categoriesController,
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      categoriesController.text = 'Plane';
                      setState(() {
                        selectedCategoryImage = 'assets/planee.png';
                        isCategorySelected = true;
                      }); // Set the selected category image
                    },
                    child: const CustomCircleIcon(
                      color: Color(0xffF35E5E),
                      image: 'assets/planee.png',
                      text: 'Plane',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoriesController.text = 'Restaurant';
                      setState(() {
                        selectedCategoryImage = 'assets/cutlery (1) 1.png';
                        isCategorySelected = true;
                      });
                    },
                    child: const CustomCircleIcon(
                      color: Color(0xff455EDF),
                      image: 'assets/cutlery (1) 1.png',
                      text: 'Restaurant',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoriesController.text = 'Car';
                      setState(() {
                        selectedCategoryImage = 'assets/car 1.png';
                        isCategorySelected = true;
                      });
                    },
                    child: const CustomCircleIcon(
                      color: Color(0xffAB73AC),
                      image: 'assets/car 1.png',
                      text: 'Car',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoriesController.text = 'Games';
                      setState(() {
                        selectedCategoryImage = 'assets/game-controller 1.png';
                        isCategorySelected = true;
                      });
                    },
                    child: const CustomCircleIcon(
                      color: Color(0xffCCC400),
                      image: 'assets/game-controller 1.png',
                      text: 'Games',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoriesController.text = 'Fuel';
                      setState(() {
                        selectedCategoryImage = 'assets/fuel 1.png';
                        isCategorySelected = true;
                      });
                    },
                    child: const CustomCircleIcon(
                      color: Color(0xff82E07A),
                      image: 'assets/fuel 1.png',
                      text: 'Fuel',
                    ),
                  ),
                ],
              ),
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
                          onTap: () {
                            categoriesController.text = 'Rent';
                            setState(() {
                              selectedCategoryImage = 'assets/rent.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Color(0xffFFA722),
                            image: 'assets/rent.png',
                            text: 'Rent',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoriesController.text = 'Movie';
                            setState(() {
                              selectedCategoryImage = 'assets/movie.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Color(0xff21DFDF),
                            image: 'assets/movie.png',
                            text: 'Movie',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoriesController.text = 'Gas';
                            setState(() {
                              selectedCategoryImage = 'assets/gas.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Color(0xff581463),
                            image: 'assets/gas.png',
                            text: 'Gas',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoriesController.text = 'Trip';
                            setState(() {
                              selectedCategoryImage = 'assets/trip.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Color(0xff4B8512),
                            image: 'assets/trip.png',
                            text: 'Trip',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            categoriesController.text = 'Other';
                            setState(() {
                              selectedCategoryImage = 'assets/other.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Color(0xffEFEB92),
                            image: 'assets/other.png',
                            text: 'Other',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: GestureDetector(
                onTap: () {
                  _selectDate();
                },
                child: Container(
                    height: 50,
                    width: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Image(
                                height: 13,
                                image: AssetImage('assets/calendar.png')),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _selectedDateTime.text,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xffC1C5C8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          width: 200,
                          color: const Color(0xffC1C5C8),
                        )
                      ],
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'Paid by',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 7),
                  DropdownButton<String>(
                    value: selectedContactValue,
                    items: [
                      const DropdownMenuItem<String>(
                          value: 'You', child: Text('You')),
                      if (widget.selectedContacts != null)
                        ...widget.selectedContacts!
                            .map((contact) => DropdownMenuItem<String>(
                                  value: contact.displayName,
                                  child: Text(contact.displayName ?? ''),
                                )),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedContactValue = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 7),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 165, bottom: 30, top: 10),
              child: Row(
                children: [
                  const Text(
                    'and Split',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 7),
                  CustomDropdownButton2(
                    hint: 'Equally',
                    value: selectedValue,
                    dropdownItems: const [
                      'Equally',
                      'Unequally',
                      'Percentage',
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_validateInputs()) {
                              storeDataToFirebase().then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabBarScreen()));
                              });
                            }
                          },
                          child:
                              reusebaleCreateGroupButton('Add Bill', context)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ThemeData.light().colorScheme.copyWith(
                    primary: const Color(
                        0xff5CAF9F), // Set the primary color to green
                  ),
            ),
            child: CalendarDatePicker(
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
              onDateChanged: (DateTime newDate) {
                Navigator.of(context).pop(newDate);
              },
            ),
          ),
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _pickedDate = picked;
        _selectedDateTime.text = formatDate(selectedDate!);
      });
    }
  }

  String formatDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day-$month-$year';
  }

  String formatDateToDaysAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else {
      return '$difference days ago';
    }
  }

  Future<void> storeDataToFirebase() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final expensesCollectionName = 'Expenses';
    final oweToCollectionName = 'Owe To';

    final description = descriptionController.text;
    final amount = amountController.text;
    final categories = categoriesController.text;

    final expensesDocumentReference =
        firestoreInstance.collection(expensesCollectionName).doc();
    final oweToDocumentReference =
        firestoreInstance.collection(oweToCollectionName).doc();
    final currentTime = DateFormat('HH:mm:ss').format(DateTime.now());

    final date = _selectedDateTime.text;
    List<String> selectedContactNames = [];
    List<String> selectedContactInitials = [];
    final serverTimestamp = FieldValue.serverTimestamp();

    if (widget.selectedContacts != null) {
      selectedContactNames = widget.selectedContacts!
          .map((contact) => contact.displayName ?? '')
          .toList();

      selectedContactInitials = widget.selectedContacts!
          .map((contact) =>
              contact.displayName != null && contact.displayName!.isNotEmpty
                  ? contact.displayName![0].toUpperCase()
                  : '')
          .toList();
    }

    // Add 'paid by' to selectedContactNames list if paid by you
    if (selectedContactValue == 'You' ||
        selectedContactNames.contains(selectedContactValue)) {
      if (selectedContactValue != null) {
        selectedContactNames.add(selectedContactValue!);

        // Calculate half of the amount
        final double totalAmount = double.tryParse(amount) ?? 0;
        final double oweToAmount = totalAmount / 2;

        // Store data in 'Owe To' collection
        await oweToDocumentReference.set({
          'description': description,
          'amount': oweToAmount.toStringAsFixed(2),
          'categories': categories,
          'date': date,
          'currentTime': currentTime,
          'selectedContacts': selectedContactNames,
          'createdAt': serverTimestamp,
          'paid by': selectedContactValue,
        });
      }
    }

    // Store data in 'Expenses' collection
    await expensesDocumentReference.set({
      'description': description,
      'amount': amount,
      'categories': categories,
      'date': date,
      'createdAt': serverTimestamp,
      'currentTime': currentTime,
      'selectedContacts': selectedContactNames,
      'Split by': selectedValue,
      'selectedContactInitials': selectedContactInitials,
      'paid by': selectedContactValue,
    });
  }
}




      // Material(
                      //   elevation: 4, // Adjust the elevation value as needed
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Container(
                      //     height: 55,
                      //     width: 342,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(
                      //           color: const Color(0xff5CAF9F), width: 1),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Container(
                      //             width: 40,
                      //             height: 45,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               shape: BoxShape.circle,
                      //               border: Border.all(
                      //                 color: const Color(0xff5CAF9F),
                      //                 width: 1.5,
                      //               ),
                      //             ),
                      //             child: const Padding(
                      //               padding: EdgeInsets.all(10.0),
                      //               child: Image(
                      //                 height: 25,
                      //                 width: 25,
                      //                 image: AssetImage('assets/signature.png'),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           width: 25,
                      //         ),
                      //         const Text(
                      //           'Write a note',
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.normal,
                      //               fontSize: 15),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Material(
                      //   elevation: 4, // Adjust the elevation value as needed
                      //   borderRadius: BorderRadius.circular(10),
                      //   child: Container(
                      //     height: 55,
                      //     width: 342,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(
                      //           color: const Color(0xff5CAF9F), width: 1),
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           child: Container(
                      //             width: 40,
                      //             height: 45,
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               shape: BoxShape.circle,
                      //               border: Border.all(
                      //                 color: const Color(0xff5CAF9F),
                      //                 width: 1.5,
                      //               ),
                      //             ),
                      //             child: const Padding(
                      //               padding: EdgeInsets.all(10.0),
                      //               child: Image(
                      //                 height: 25,
                      //                 width: 25,
                      //                 image: AssetImage('assets/camera.png'),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(
                      //           width: 25,
                      //         ),
                      //         const Text(
                      //           'Add a Reciept',
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.normal,
                      //               fontSize: 15),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),