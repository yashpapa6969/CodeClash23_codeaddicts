
import 'dart:io';

import 'package:curious/provider/posts_provider.dart';
import 'package:curious/utils/colorConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class Anwser extends StatefulWidget {
  const Anwser({
    Key? key,
  }) : super(key: key);


  @override
  State<Anwser> createState() => _AnwserState();
}

class _AnwserState extends State<Anwser> {



  @override
  Widget build(BuildContext context) {
    var reg = Provider.of<PostsProvider>(context);


    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return
      Scaffold(
        backgroundColor:Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [



                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 20,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Answers",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  height: 50,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: const InputDecoration(fillColor: ConstantColors.button, filled: true, border: InputBorder.none),
                    controller: reg.anwserController,

                  ),
                ),


                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                      width: width,
                      height: 50,
                      padding:  EdgeInsets.only(left: 20, right: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:  ConstantColors.button,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          reg.postAnwser(context);

                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: 71.13,
                            child: const Text(
                              "Submit",
                              style: TextStyle(
                                color: ConstantColors.text,
                                fontSize: 20,
                              ),
                            )),

                      )),
                ),
                SizedBox(height: 20,)
              ])),
        ),

      );
  }
}