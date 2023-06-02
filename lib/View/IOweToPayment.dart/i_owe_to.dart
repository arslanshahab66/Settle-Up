import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:settle_up_expenses/View/contacts_helper.dart';
import 'package:settle_up_expenses/View/tab_bar.dart';
import '../../Widgets/avatar_widget.dart';
import '../../Widgets/create_group_button.dart';
import '../../Widgets/reuseable_container.dart';
import 'Owe_to_payment_contact.dart';

class IOweToScreen extends StatefulWidget {
  final List<Contact>? selectedContacts;

  const IOweToScreen({Key? key, this.selectedContacts}) : super(key: key);

  @override
  State<IOweToScreen> createState() => _IOweToScreenState();
}

class _IOweToScreenState extends State<IOweToScreen> {
  TextEditingController _selectedDateTime = TextEditingController();
  DateTime? selectedDate;
  DateTime? _pickedDate;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();

  String selectedCategoryImage = 'assets/planee.png';
  bool isCategorySelected = false;

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
  void initState() {
    super.initState();
    if (selectedDate != null) {
      _selectedDateTime.text = formatDateToDaysAgo(selectedDate!);
    } else {
      _selectedDateTime.text = 'Dates';
    }
  }

  // String? selectedValue;
  // String? selectedContactValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xff5CAF9F),
        title: const Text('I Owe To'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 7),
                  GestureDetector(
                    onTap: () {
                      ContactsHelper.getContactsPermission(context)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OweToContactList()));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xff5CAF9F)),
                              borderRadius: BorderRadius.circular(10)),
                          width: 170,
                          height: 30,
                          child: const Center(child: Text('I owe to:')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 7),
                ],
              ),
            ),
            Column(
              children: [
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
                                            displayName:
                                                contact.displayName ?? ''),
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
                                          widget.selectedContacts!
                                              .removeAt(index);
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
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
                              selectedCategoryImage = 'assets/more.png';
                              isCategorySelected = true;
                            });
                          },
                          child: const CustomCircleIcon(
                            color: Colors.grey,
                            image: 'assets/more.png',
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
              child: Container(
                  height: 50,
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate();
                        },
                        child: Row(
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
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (_validateInputs()) {
                              storeOweToDataInFirebase().then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TabBarScreen()));
                              });
                            }
                          },
                          child: reusebaleCreateGroupButton('Save', context)),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            )
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

  Future<void> storeOweToDataInFirebase() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final collectionName = 'Owe To';

    final description = descriptionController.text;
    final amount = amountController.text;
    final categories = categoriesController.text;

    final documentReference =
        firestoreInstance.collection(collectionName).doc();
    final date = _selectedDateTime.text;
    List<String> selectedContactNames = [];
    final serverTimestamp = FieldValue.serverTimestamp();
    // final currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    final currentTime =
        DateFormat('HH:mm:ss, d MMMM, yyyy').format(DateTime.now());
    if (widget.selectedContacts != null) {
      selectedContactNames = widget.selectedContacts!
          .map((contact) => contact.displayName ?? '')
          .toList();

      await documentReference.set({
        'description': description,
        'amount': amount,
        'categories': categories,
        'currentTime': currentTime,
        'date': date,
        'selectedContacts': selectedContactNames,
        'createdAt': serverTimestamp,
      });
    }
  }
}
