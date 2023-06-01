import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../Widgets/dialog_box_widget.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _retrieveContacts();
  }

  Future<void> _retrieveContacts() async {
    setState(() {
      isLoading = true;
    });
    Iterable<Contact> retrievedContacts = await ContactsService.getContacts();
    setState(() {
      contacts = retrievedContacts.toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Add Friend'),
          backgroundColor: const Color(0xff5CAF9F),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff5CAF9F),
                  color: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(children: [
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
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = contacts[index];
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

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                    title: 'Add this contact to splitwise?',
                                    hintText: 'Enter Number',
                                    onAdd: (value) {},
                                    onEdit: (value) {
                                      // handle edit logic
                                    },
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: avatarWidget,
                              title: Text(
                                displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(phoneNumber),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                        )
                      ],
                    );
                  },
                ),
              ])));
  }
}
