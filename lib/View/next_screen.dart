import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class NextScreen extends StatefulWidget {
  final List<Contact> selectedContacts;

  const NextScreen({Key? key, required this.selectedContacts})
      : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected contacts"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.selectedContacts.length,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = widget.selectedContacts[index];
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
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : '',
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
                  // width: 125,
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
                        CircleAvatar(
                          backgroundColor: const Color(0xff5CAF9F),
                          child: Text(
                            displayName.isNotEmpty
                                ? displayName[0].toUpperCase()
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            contact.displayName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
              ],
            ),
          );
        },
      ),
    );
  }
}


// Container(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: const Color(0xff5CAF9F),
          //         child: Text(
          //           displayName.isNotEmpty ? displayName[0].toUpperCase() : '',
          //           style: const TextStyle(
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //      const SizedBox(height: 8.0),
          //       Text(
          //         contact.displayName ?? "",
          //         style: const TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //      const SizedBox(height: 4.0),
          //       Text(contact.phones?.isNotEmpty ?? false
          //           ? contact.phones!.first.value ?? ""
          //           : ""),
          //     ],
          //   ),
          // );