import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo TextFormField",
      home: TextFormFieldExamble(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TextFormFieldExamble extends StatefulWidget {
  const TextFormFieldExamble({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFormFieldExampleState();
}

class _TextFormFieldExampleState extends State<TextFormFieldExamble> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  String? _name;
  String? _phoneNumber;
  String? _email;
  String? _password;

  String? _validateName(String? value) {
    if (value?.isEmpty ?? false) {
      return "Name is required.";
    }
    final RegExp nameExp = RegExp(r'^[A-Za-z]+$');
    if (!nameExp.hasMatch(value!)) {
      return "Please enter only alphabetical characters!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 24),
          // "Name" From
          TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.person),
                hintText: "What do people call you?",
                labelText: "Name *"),
            onSaved: (String? value) {
              this._name = value;
              print("Name is : $value");
            },
            validator: _validateName,
          ),
          const SizedBox(height: 24.0),
          // "Phone number" form
          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                filled: true,
                icon: Icon(Icons.phone),
                hintText: "Where can we reach you?",
                labelText: "Phone Number *",
                prefixText: "+84"),
            keyboardType: TextInputType.phone,
            onSaved: (String? value) {
              this._phoneNumber = value;
              print("Phone number is : $value");
            },
          ),
          const SizedBox(height: 24.0),
          //
        ],
      ),
    );
  }
}
