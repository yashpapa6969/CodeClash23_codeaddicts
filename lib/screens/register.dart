import 'package:curious/provider/auth_provider.dart';
import 'package:curious/screens/main_class.dart';
import 'package:flutter/material.dart';
import 'package:curious/Utils/color_utils.dart';
import 'package:curious/Reusable_widgets/password_field.dart';
import 'package:curious/Reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late String myError;

  @override
  Widget build(BuildContext context) {
    var reg = Provider.of<AuthProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: const Color.fromARGB(255, 46, 51, 82)
              .withOpacity(0.9), //change your color here
        ),
        title: Text(
          '',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 46, 51, 82).withOpacity(0.9)),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor('#EDE6CB'),
              hexStringToColor('#F6F5F3'),
              hexStringToColor('#FCFBF9'),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            child: Column(
              children: <Widget>[
            const SizedBox(
            height: 20,
            ),
            reusableTextField("Name",
                Icons.person_outlined, false, reg.nameController),
            const SizedBox(
              height: 20,
            ),
                reusableTextField("Usn",
                    Icons.abc, false, reg.usnController),
                const SizedBox(
                  height: 20,
                ),
            reusableTextField("Email", Icons.email_outlined, false,
                reg.emailController),
            const SizedBox(
              height: 20,
            ),
            PasswordField(
              controller: reg.passwordController,
            ),
            const SizedBox(
              height: 20,
            ),

                Container(width: width,height: 40,
                  child: ElevatedButton(
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontStyle: FontStyle.italic
                      ),
                    ),
                    onPressed: () {
                      reg.register(context);

                      print('Pressed');
                    },
                  ),
                )
              ],
          ),
        ),
      ),
    ),);
  }}