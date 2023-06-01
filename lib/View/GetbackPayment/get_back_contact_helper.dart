import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactsHelper {
static Future<void> getContactsPermission(context) async {
  PermissionStatus permissionStatus = await Permission.contacts.request();
  if (permissionStatus.isGranted) {
    // Permission is granted, proceed with retrieving contacts
    retrieveContacts();
  } else {
    // Permission denied, handle accordingly
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contacts Permission'),
        content: const Text('Please grant permission to access contacts.'),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child:  const Text('Allow'),
            onPressed: () async {
              Navigator.pop(context);
              PermissionStatus permissionStatus =
                  await Permission.contacts.request();
              if (permissionStatus.isGranted) {
                retrieveContacts();
              } else {
                // Permission denied, handle accordingly
                showDialog(
                 context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Permission Denied'),
                    content: Text('Unable to access contacts.'),
                    actions: [
                      ElevatedButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

  static Future<void> retrieveContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    // Process the retrieved contacts as needed
    for (Contact contact in contacts) {
      String displayName = contact.displayName ?? '';
      String phoneNumber =
          contact.phones!.isNotEmpty ? contact.phones!.first.value ?? '' : '';
      // Do something with the contact's display name and phone number
      print('Name: $displayName, Phone: $phoneNumber');
    }
  }
}
