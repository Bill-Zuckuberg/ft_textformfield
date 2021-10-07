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
          Material(
            child: TextFormField(
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
          ),
          const SizedBox(height: 24.0),
          // "Phone number" form
          Material(
            child: TextFormField(
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
          ),
          const SizedBox(height: 24.0),
          // "Email " form
          Material(
            child: TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: false,
                  icon: Icon(Icons.email),
                  hintText: "Your email address",
                  labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {
                this._email = value;
                print("Email is : $value");
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // "Life story" form
          Material(
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Tell us about yourself",
                  helperText: "Keep it short, this is just a demo",
                  labelText: "Life story"),
              maxLines: 3,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // "Salary" form
          Material(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Salary",
                  prefixText: "\$",
                  suffixText: "USD",
                  suffixStyle: TextStyle(color: Colors.green)),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          // "Password" form
          PasswordFiel(
            fieldKey: _passwordFieldKey,
            helperText: "No more than 8 character.",
            labelText: "Passwor *",
            onFieldSubmitted: (String value) {
              setState(() {
                this._password = value;
              });
            },
          )
        ],
      ),
    );
  }
}

class PasswordFiel extends StatefulWidget {
  const PasswordFiel(
      {this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted});

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordFiel> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        key: widget.fieldKey,
        obscureText: _obscureText,
        maxLength: 8,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            filled: true,
            hintText: widget.hintText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child:
                  Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            )),
      ),
    );
  }
}
