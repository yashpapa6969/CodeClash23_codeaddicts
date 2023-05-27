
import 'dart:io';

import 'package:curious/provider/posts_provider.dart';
import 'package:curious/utils/colorConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import 'package:provider/provider.dart';


class Ask extends StatefulWidget {
  const Ask({
    Key? key,
  }) : super(key: key);


  @override
  State<Ask> createState() => _AskState();
}

class _AskState extends State<Ask> {
  final ImagePicker _picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    var reg = Provider.of<PostsProvider>(context);


    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    void _settingModalBottomSheet() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SizedBox(
              height: 150,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () async {
                        Navigator.pop(context);
                        final pickedFile = await _picker.pickImage(source: ImageSource.camera, maxHeight: 500, maxWidth: 500, imageQuality: 50);
                        reg.uploadProfileImage(pickedFile!.path);


                      }),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('Gallery'),
                    onTap: () async {
                      Navigator.pop(context);
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 500, maxWidth: 500, imageQuality: 50);
                       reg.uploadProfileImage(pickedFile!.path);
                    },
                  ),
                ],
              ),
            );
          });
    }

    return
      Scaffold(
        backgroundColor:Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [

                Container(
                    height: 150,
                    width: 115,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _settingModalBottomSheet();
                            },
                            child: reg.profileImage.isEmpty
                                ? Container(
                                child: Image(
                                  fit: BoxFit.fitWidth,
                                  height: 150,
                                  width: 300,
                                  image: Image.network('https://www.pngkit.com/png/detail/353-3536328_generic-placeholder-image-question-and-answer-signs.png').image,
                                ))
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.file(
                                File(reg.profileImage),
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            )),
                      ],
                    )),

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
                      "Question",
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
                    controller: reg.questionController,

                  ),
                ),
                Visibility(
                  visible: reg.questionError,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "*Name is Invalid.",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Tags",
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
                    controller: reg.tagController,

                  ),
                ),
                Visibility(
                  visible: reg.tagError,
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "*Email is Invalid.",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                  const SizedBox(
                    width: 10,
                  ),

                const SizedBox(
                  height: 10,
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
                         reg.postQuestion(context);

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