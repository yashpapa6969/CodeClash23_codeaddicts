import 'package:curious/provider/auth_provider.dart';
import 'package:curious/screens/main_class.dart';
import 'package:flutter/material.dart';
import 'package:curious/Utils/color_utils.dart';
import 'package:flutter_svg/svg.dart';
import 'package:curious/Reusable_widgets/password_field.dart';
import 'package:curious/Reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  late String myError;




  @override
  Widget build(BuildContext context) {
    var reg = Provider.of<AuthProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/bezCircle.png'),
              Image.asset('assets/images/redCircle.png'),
              Image.asset('assets/images/purpleCircle.png'),
              Image.asset('assets/images/orangeCircle.png'),
              Positioned(
                top: 0,
                left: 50,
                child: Image.asset('assets/svg/curisityhub_logo.png')
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 240,
                    ),
                    reusableTextField("Email", Icons.person_outlined, false,
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));

                          reg.login(context);

                          print('Pressed');
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
