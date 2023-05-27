import 'dart:async';

import 'package:badges/badges.dart';
import 'package:curious/provider/posts_provider.dart';
import 'package:curious/screens/anwserList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool _isLoading = false;
  static var _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      Provider.of<PostsProvider>(context, listen: false).getAllQuestions();

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
        body: SafeArea(child:
           SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [

                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount:data.TypeItems.length,
                      itemBuilder: (context, i) => SizedBox(
                        height:150,
                        child: GestureDetector(
                          onTap: (){
                            data.updateQid(data.TypeItems[i].questionId);

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Anwserlist()));
                          },
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
                                          Text(data.TypeItems[i].question,
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
                                  child: Text(data.TypeItems[i].tag,

                                  ),
                                ),
                                // the validation here because in the api there is just one description field is filled others is empty. So I filled them with below text..

                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                     Icon(Icons.arrow_upward),
                                     Text('Vote'),
                                     Icon(Icons.arrow_downward),
                                     Icon(Icons.chat_bubble),
                                    Text(""),
                                     Icon(Icons.share),
                                     Text('Share'),
                                     Icon(Icons.redeem),
                                  ],
                                )
                              ],
                            ),
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