
import 'package:curious/Utils/color_utils.dart';
import 'package:curious/screens/login.dart';
import 'package:curious/screens/register.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const Color black = Color(0xFF000000);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,

        colors: [
        hexStringToColor('#EDE6CB'),
    hexStringToColor('#F6F5F3'),
    hexStringToColor('#FCFBF9'),
    ],
      ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: height * 0.05, left: 20, right: 20, bottom: height * 0.1),
              child: Column(
                children: [
                 Container(
                                        decoration: const BoxDecoration(color: Colors.transparent),
                                        child: Center(
                                          child: Container(
                                            child: Image(
                                              image: Image.asset('assets/svg/curisityhub_logo.png').image,
                                              height: height/2,
                                              width: width,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )),


                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: const Text(
                      "",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff1f1d1d),
                        fontSize: 28,
                        fontFamily: "lato",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: width * 0.38,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff1f1d1d),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: Ink(

                              child: const Text(
                                "REGISTER",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: "Lato",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.38,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0x19000000),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x19000000),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignInScreen()));
                            },
                            child: const Text(
                              "Sign In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff1f1d1d),
                                fontSize: 16,
                                fontFamily: "Lato",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

