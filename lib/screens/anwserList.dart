import 'dart:async';

import 'package:badges/badges.dart';
import 'package:curious/provider/posts_provider.dart';
import 'package:curious/screens/anwser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anwserlist extends StatefulWidget {
  const Anwserlist({Key? key}) : super(key: key);

  @override
  State<Anwserlist> createState() => _AnwserlistState();
}

class _AnwserlistState extends State<Anwserlist> {
  bool _isLoading = false;


  static var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<PostsProvider>(context, listen: false).getAllAnwsers();

      setState(() {
        _isInit = false;
      });
    }
  }

  @override
  void dispose() {
    setState(() {
      _isInit = true;
    });

    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    var data = Provider.of<PostsProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        initialIndex: 1,
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Anwser()));
            },
            child: Text("Anwser"),
          ),
          body: SafeArea(child:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    child: Text("Anwser",  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,),
                  ),

                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount:data.Items.length,
                      itemBuilder: (context, i) => SizedBox(
                        height:150,
                        child: Card(
                          elevation: 2,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            backgroundColor:
                                            Colors.transparent,
                                            child:
                                            Image.network(
                                              "https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png",
                                              fit: BoxFit.cover,
                                            )

                                        ),
                                        const SizedBox(width: 5),
                                        Text(data.Items[i].answer
                                            ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Chip(
                                        labelPadding: const EdgeInsets
                                            .symmetric(
                                          horizontal: 10,
                                        ),
                                        label: const Text(
                                          'Join',
                                          textAlign: TextAlign.center,
                                          style:
                                          TextStyle(fontSize: 13),
                                        ),
                                        backgroundColor: Colors.blue,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.more_horiz),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(""

                                ),
                              ),
                              // the validation here because in the api there is just one description field is filled others is empty. So I filled them with below text..


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        )
    );
  }
}