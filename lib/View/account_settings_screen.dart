import 'package:flutter/material.dart';
import 'package:settle_up_expenses/Widgets/create_group_button.dart';
import '../Widgets/custom_text_field.dart';
import '../Widgets/reminder_setting_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});
  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

bool isChecked = false;

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff5CAF9F),
        title: const Text(
          'Account Settings',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    elevation: 4.0,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xffD9D9D9),
                        width: 1.0,
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.325,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: const SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.all(20.0),
                              child: Column(
                                children:  [
                                  CustomTextField(
                                    hintText: 'User Name',
                                    prefixIconPath: 'assets/user.png',
                                    hintStyle: TextStyle(
                                      color: Color(0xffC1C5C8),
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    hintText: 'Email Address',
                                    prefixIconPath: 'assets/mail.png',
                                    hintStyle: TextStyle(
                                      color: Color(0xffC1C5C8),
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    hintText: 'Phone Number',
                                    prefixIconPath: 'assets/phone.png',
                                    hintStyle: TextStyle(
                                      color: Color(0xffC1C5C8),
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextField(
                                    hintText: 'Password',
                                    prefixIconPath: 'assets/lock.png',
                                    hintStyle: TextStyle(
                                      color: Color(0xffC1C5C8),
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 15.0),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ReminderSettingsSection(
                              title: 'Reminder Settings',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xffC1C5C8),
                                    ), // Replace with your desired color
                                  ),
                                  hintText: 'Send as Sms',
                                  hintStyle: TextStyle(
                                      color: Color(0xffC1C5C8), fontSize: 14),
                                ),
                              ),
                            ),
                            ReminderSettingsSection(
                              title: 'Default Currency',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC1C5C8),
                                      ), // Replace with your desired color
                                    ),
                                    hintText: 'INR',
                                    hintStyle: TextStyle(
                                        color: Color(0xffC1C5C8),
                                        fontSize: 14)),
                              ),
                            ),
                            ReminderSettingsSection(
                              title: 'Language (for emails and notifications)',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC1C5C8),
                                      ), // Replace with your desired color
                                    ),
                                    hintText: 'English',
                                    hintStyle: TextStyle(
                                        color: Color(0xffC1C5C8),
                                        fontSize: 14)),
                              ),
                            ),
                            ReminderSettingsSection(
                              title: 'Time Zone',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xffC1C5C8),
                                      ), // Replace with your desired color
                                    ),
                                    hintText: '(GMT + 00:00)UTC',
                                    hintStyle: TextStyle(
                                        color: Color(0xffC1C5C8),
                                        fontSize: 14)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked =
                                            value!; // Update the checkbox state
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Allow other group expenses users to\n find me by email or phone number',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  reusebaleCreateGroupButton('Save', context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
