import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:settle_up_expenses/View/add_bill_screen.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> _contacts = [];
  List<Contact> _selectedContacts = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    setState(() {
      isLoading = true;
    });

    Iterable<Contact> retrievedContacts = await ContactsService.getContacts();

    if (mounted) {
      setState(() {
        _contacts = retrievedContacts.toList();
        isLoading = false;
      });
    }
  }

  void _confirmContactAddition(Contact contact) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add contact"),
          content: Text("Do you want to add ${contact.displayName}?"),
          actions: [
            TextButton(
              child: const Text("Cancel",
                  style: TextStyle(color: Color(0xff5CAF9F))),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Color(0xff5CAF9F)),
              ),
              onPressed: () {
                setState(() {
                  _selectedContacts.add(contact);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AddBillScreen(selectedContacts: _selectedContacts),
      ),
    );
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
          ? Center(
              child: Container(
                height: 60,
                alignment: Alignment.center,
                child: Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_uW9CQN.json',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            )
          : SingleChildScrollView(
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
                            style: const TextStyle(
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
                    itemCount: _contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Contact contact = _contacts[index];
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
                      if (_searchController.text.isEmpty) {
                        return Column(
                          children: [
                            ListTile(
                              leading: avatarWidget,
                              title: Text(
                                displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(phoneNumber),
                              onTap: () {
                                _confirmContactAddition(contact);
                              },
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            )
                          ],
                        );
                      } else if (contact.displayName != null &&
                          contact.displayName!
                              .toLowerCase()
                              .contains(_searchController.text.toLowerCase()))
                      // Rest of your code...
                      {
                        return Column(
                          children: [
                            ListTile(
                              leading: avatarWidget,
                              title: Text(
                                displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(phoneNumber),
                              onTap: () {
                                _confirmContactAddition(contact);
                              },
                            ),
                            const Divider(
                              height: 1,
                              thickness: 1,
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff5CAF9F),
        onPressed: _selectedContacts.isNotEmpty ? _navigateToNextScreen : null,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
