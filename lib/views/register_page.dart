import 'package:flutter/material.dart';
import 'package:tutor_app/logic/login_functions.dart';
import 'package:tutor_app/styling/buttons.dart';
import 'package:tutor_app/styling/dropdown.dart';
import '../styling/text_edits.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final nameController = TextEditingController();
  final List<String> items = ['Math', "English", "Chemistry", "Physics", "SOR"];
  List<String> selectedItems = [];
  bool isChecked = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffffffff),
      body: Align(
        // Centers content
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // * Title text
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 30),
                child: Text(
                  "ToDo",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Color.fromARGB(255, 128, 149, 253),
                  ),
                ),
              ),
              // * Login title text
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Register",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 24,
                    // color: Color(0xff000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                child: createTextField(
                    controller: nameController, labelText: "Name"),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: multiSelect(
                    context: context,
                    items: items,
                    selectedItems: selectedItems,
                    onStateChanged: () {
                      setState(() {});
                      print(selectedItems.toString());
                    },
                  ),
                ),
              ),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: createButton(
                    label: "Submit",
                    action: () async {
                      await register(
                          subjects: selectedItems,
                          name: nameController.text,
                          tutor: isChecked);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
