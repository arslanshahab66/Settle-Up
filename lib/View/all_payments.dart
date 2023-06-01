import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/custom_bottomsheet.dart';
import '../Widgets/reuseable_list_tile.dart';
import 'GetbackPayment/payment.dart';

class AllPaymentsScreen extends StatefulWidget {
  const AllPaymentsScreen({Key? key}) : super(key: key);

  @override
  State<AllPaymentsScreen> createState() => _AllPaymentsScreenState();
}

class _AllPaymentsScreenState extends State<AllPaymentsScreen> {
  final String collectionName = 'GetBack';
  late String currentDate;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentDate = _getCurrentDateTime(); // Initialize currentDate
  }

  DateTime preprocessDateString(String dateString) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (dateString == 'Today') {
      return today;
    } else if (dateString == 'Yesterday') {
      return yesterday;
    } else {
      final matches = RegExp(r'^(\d+)-(\d+)-(\d+)$').firstMatch(dateString);
      if (matches != null) {
        final day = int.parse(matches.group(1)!);
        final month = int.parse(matches.group(2)!);
        final year = int.parse(matches.group(3)!);
        return DateTime(year, month, day);
      }
    }
    return DateTime.now(); // Return current date as a fallback
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Payments'),
          backgroundColor: Color(0xff5CAF9F),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 30, // Set the height of the container
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: _searchController,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Color(0xff5CAF9F),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff5CAF9F),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xff5CAF9F),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Expenses')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text('Loading...');
                        }

                        double totalBalance = 0;
                        for (var document in snapshot.data!.docs) {
                          final dataMap =
                              document.data() as Map<String, dynamic>;
                          final amount =
                              double.tryParse(dataMap['amount'].toString()) ??
                                  0; // Parse as double
                          totalBalance += amount;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Total Balance:',
                                style: TextStyle(color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                totalBalance.toString(),
                                style: const TextStyle(
                                  color: Color(0xff5CAF9F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.13,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Expenses')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  }

                  return SingleChildScrollView(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.where((document) {
                        final dataMap = document.data() as Map<String, dynamic>;
                        final contact = dataMap['selectedContacts'][0] ?? '';
                        return _searchController.text.isEmpty ||
                            contact.toLowerCase().contains(
                                  _searchController.text.toLowerCase(),
                                );
                      }).length,
                      itemBuilder: (BuildContext context, int index) {
                        final filteredDocs =
                            snapshot.data!.docs.where((document) {
                          final dataMap =
                              document.data() as Map<String, dynamic>;
                          final contact = dataMap['selectedContacts'][0] ?? '';
                          return _searchController.text.isEmpty ||
                              contact.toLowerCase().contains(
                                    _searchController.text.toLowerCase(),
                                  );
                        }).toList();

                        final document = filteredDocs[index];
                        final dataMap = document.data() as Map<String, dynamic>;

                        final date = preprocessDateString(dataMap['date']);
                        String formattedDate =
                            DateFormat('d-MM-yyyy').format(date);

                        final selectedContactValue =
                            dataMap['paid by'].toString();
                        final splitBy = dataMap['Split by'].toString();
                        final contact = dataMap['selectedContacts'][0] ?? '';

                        return Column(
                          children: [
                            ReusableListTile(
                              selectedContactInitial:
                                  dataMap['selectedContacts']?.isNotEmpty ==
                                          true
                                      ? dataMap['selectedContacts']![0]
                                              .isNotEmpty
                                          ? dataMap['selectedContacts']![0][0]
                                              .toUpperCase()
                                          : ''
                                      : '',
                              avatarImagePath: '',
                              titleText: dataMap['selectedContacts'][0] ?? '',
                              subtitleLocation: dataMap['description'],
                              subtitleTravel: dataMap['categories'],
                              subtitleTravelIcon:
                                  _getCategoryIcon(dataMap['categories']),
                              subtitleDaysAgo: formattedDate,
                              trailingCount: dataMap['amount'].toString(),
                              color: Colors.black,
                              trailingText: 'added',
                              // trailingIconPath: 'assets/arrow_downward.png',
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CustomBottomSheet.show(context);
          },
          backgroundColor: const Color(0xff5CAF9F),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/add.png'),
          ),
        ),
      ),
    );
  }

  String? _getCategoryIcon(String? category) {
    if (category == 'Car' || category == 'car') {
      return 'assets/car 1.png';
    } else if (category == 'Plane' || category == 'plane') {
      return 'assets/planee.png';
    } else if (category == 'Games' || category == 'games') {
      return 'assets/game-controller 1.png';
    } else if (category == 'Restaurant' || category == 'restaurant') {
      return 'assets/cutlery (1) 1.png';
    } else if (category == 'Fuel' || category == 'fuel') {
      return 'assets/fuel 1.png';
    } else if (category == 'Rent' || category == 'rent') {
      return 'assets/rent.png';
    } else if (category == 'Movie' || category == 'movie') {
      return 'assets/movie.png';
    } else if (category == 'Gas' || category == 'gas') {
      return 'assets/gas.png';
    } else if (category == 'Trip' || category == 'trip') {
      return 'assets/trip.png';
    } else if (category == 'Other' || category == 'other') {
      return 'assets/other.png';
    }
    // Add more conditions for other categories as needed
    return null; // Return null if no matching category is found
  }

  String _getCurrentDateTime() {
    final now = DateTime.now();
    final formattedDate = DateFormat('d-MM-yyyy').format(now);
    return formattedDate;
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../Widgets/custom_bottomsheet.dart';
// import '../Widgets/reuseable_list_tile.dart';

// class TotalBalanceScreen extends StatefulWidget {
//   const TotalBalanceScreen({Key? key}) : super(key: key);

//   @override
//   _TotalBalanceScreenState createState() => _TotalBalanceScreenState();
// }

// class _TotalBalanceScreenState extends State<TotalBalanceScreen> {
//   final String collectionName = 'Expenses';

//   DateTime preprocessDateString(String dateString) {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final yesterday = today.subtract(const Duration(days: 1));
//     if (dateString == 'Today') {
//       return today;
//     } else if (dateString == 'Yesterday') {
//       return yesterday;
//     } else {
//       final matches = RegExp(r'^(\d+)\s+(\w+)\s+ago$').firstMatch(dateString);
//       if (matches != null) {
//         final count = int.parse(matches.group(1)!);
//         final unit = matches.group(2);
//         switch (unit) {
//           case 'days':
//             return today.subtract(Duration(days: count));
//           case 'weeks':
//             return today.subtract(Duration(days: count * 7));
//           case 'months':
//             return today.subtract(Duration(days: count * 30));
//           case 'years':
//             return today.subtract(Duration(days: count * 365));
//         }
//       }
//     }
//     return DateFormat('MM/dd/yyyy').parse(dateString);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10, left: 20),
//               child: Row(
//                 children: [
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Expenses')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       }

//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Text('Loading...');
//                       }

//                       int totalBalance = 0;
//                       for (var document in snapshot.data!.docs) {
//                         final dataMap = document.data() as Map<String, dynamic>;
//                         final amount =
//                             int.tryParse(dataMap['amount'] ?? '0') ?? 0;
//                         totalBalance += amount;
//                       }

//                       return Padding(
//                         padding: const EdgeInsets.only(top: 10, left: 10),
//                         child: Row(
//                           children: [
//                             const Text(
//                               'Total Balance:',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               '\$${totalBalance.toString()}',
//                               style: const TextStyle(
//                                 color: Color(0xff5CAF9F),
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('Expenses').snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Text('Loading...');
//                 }

//                 return ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: snapshot.data?.docs.length ?? 0,
//                   itemBuilder: (BuildContext context, int index) {
//                     if (snapshot.data == null) {
//                       return const SizedBox(); // Return an empty widget if data is null
//                     }

//                     final dataMap = snapshot.data!.docs[index].data()
//                         as Map<String, dynamic>;
//                     final date = preprocessDateString(dataMap['date']);
//                     String formattedDate =
//                         DateFormat('MM/dd/yyyy').format(date);

//                     if (date == DateTime.now()) {
//                       formattedDate = 'Today';
//                     } else if (date ==
//                         DateTime.now().subtract(Duration(days: 1))) {
//                       formattedDate = 'Yesterday';
//                     } else {
//                       final difference = DateTime.now().difference(date);
//                       if (difference.inDays > 0) {
//                         formattedDate = '${difference.inDays} days ago';
//                       } else if (difference.inHours > 0) {
//                         formattedDate = '${difference.inHours} hours ago';
//                       } else if (difference.inMinutes > 0) {
//                         formattedDate = '${difference.inMinutes} minutes ago';
//                       } else {
//                         formattedDate = 'Just now';
//                       }
//                     }

//                     final amount =
//                         int.tryParse(dataMap['amount']?.toString() ?? '0') ?? 0;
//                     final isPositive = amount >= 0;

//                     String getSplitByValue(Map<String, dynamic> dataMap) {
//                       return dataMap['split by'] ?? '';
//                     }

//                     String balanceMessage = isPositive
//                         ? 'Someone owed me \$${amount.abs()}'
//                         : 'I owed someone \$${amount.abs()}';

//                     final splitBy = getSplitByValue(dataMap);
//                     if (splitBy == 'Unequally') {
//                       final selectedContacts =
//                           dataMap['selectedContacts'] as List<dynamic>?;
//                       if (selectedContacts != null &&
//                           selectedContacts.isNotEmpty) {
//                         final splitAmount =
//                             (amount / selectedContacts.length).abs();
//                         final balanceMessage = isPositive
//                             ? 'I am owed'
//                             : 'I owe ${selectedContacts[0]}';

//                         return Column(
//                           children: [
//                             ReusableListTile(
//                               selectedContactInitial:
//                                   dataMap['selectedContacts'][0],
//                               avatarImagePath: '',
//                               titleText: dataMap['selectedContacts'][0],
//                               subtitleLocation: dataMap['description'],
//                               subtitleTravel: dataMap['categories'],
//                               subtitleDaysAgo: formattedDate,
//                               trailingCount: splitAmount.toString(),
//                               trailingText: balanceMessage,
//                               trailingIconPath: 'assets/arrow_downward.png',
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                           ],
//                         );
//                       }
//                     } else if (splitBy == 'Percentage') {
//                       final selectedContacts =
//                           dataMap['selectedContacts'] as List<dynamic>?;
//                       if (selectedContacts != null &&
//                           selectedContacts.isNotEmpty) {
//                         final splitPercentage = dataMap['Percentage'] ?? 0;
//                         final splitAmount =
//                             (amount * splitPercentage / 100).abs();
//                         final balanceMessage = isPositive
//                             ? 'I am owed'
//                             : 'I owe ${selectedContacts[0]}';

//                         return Column(
//                           children: [
//                             ReusableListTile(
//                               selectedContactInitial:
//                                   dataMap['selectedContacts'][0],
//                               avatarImagePath: '',
//                               titleText: dataMap['selectedContacts'][0],
//                               subtitleLocation: dataMap['description'],
//                               subtitleTravel: dataMap['categories'],
//                               subtitleDaysAgo: formattedDate,
//                               trailingCount: splitAmount.toString(),
//                               trailingText: balanceMessage,
//                               trailingIconPath: 'assets/arrow_downward.png',
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                           ],
//                         );
//                       }
//                     }

//                     return const SizedBox();
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           CustomBottomSheet.show(context);
//         },
//         backgroundColor: const Color(0xff5CAF9F),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset('assets/add.png'),
//         ),
//       ),
//     ));
//   }
// }
