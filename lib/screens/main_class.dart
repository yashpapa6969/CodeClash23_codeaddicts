import 'dart:io';
import 'package:curious/screens/WebView.dart';
import 'package:curious/screens/about_first.dart';
import 'package:curious/screens/ask_doubts.dart';
import 'package:curious/screens/posts.dart';
import 'package:curious/screens/slider.dart';
import 'package:curious/video/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/mainscreen';

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {


  late ScrollController _scrollController;
  late final PageController _c = PageController(
    initialPage: 0,
  );

  double offset = 0.0;

  int _selectedIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();

  }

  void _onItemTapped(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_c.hasClients) {
        _c.animateToPage(index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut);

        setState(() {
          _selectedIndex = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:  Color.fromRGBO(245, 245, 245, 1),
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    //double width = MediaQuery.of(context).size.width;
    List<String> headers  = ["Posts","Ask Qustions","Accountability"];

    List<Widget> widgetOptions = <Widget>[
      Posts(),
      Ask(),
      MyApp(),

    ];
    final width= MediaQuery.of(context).size.width;
    final  height = MediaQuery.of(context).size.height;

    return Scaffold(




      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black12,
                size: 25,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          headers[_selectedIndex],
          style: const TextStyle(
            fontFamily: 'medium',
            fontSize: 18,
            color: Color(0xff000000),
          ),
          textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
          textAlign: TextAlign.center,
          softWrap: false,
        ),


      ),
      drawer: Container(
          color: Colors.white,
          width: width * 0.8,
          height: height,
          child: Drawer(
              backgroundColor: Colors.white,
              child: Container(
                height: height,

                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Container(
                       height: height,

                       color: Colors.white,
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50, left: 30, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => WebViewExample(
                                                  url: "https://corfin.in/user/register",
                                                )));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          const SizedBox(width: 15),
                                          const Text(
                                            "Research Papers",
                                            style: TextStyle(color: Colors.black, fontFamily: "regular", fontSize: 17,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(
                                    height: 45,
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => VideoCallScreen(
                                                )));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          const SizedBox(width: 15),
                                          const Text(
                                            "Ask Your Doubts",
                                            style: TextStyle(color: Colors.black, fontFamily: "regular", fontSize: 17,fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Builder(
                                    builder: (csontext) => GestureDetector(
                                      onTap: () async {
                                        Scaffold.of(csontext).openEndDrawer();
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(builder: (context) => About()));                                      },
                                      child: Container(
                                        height: 50,
                                        width: width * 0.5,
                                        margin: const EdgeInsets.only(left: 20),
                                        padding: const EdgeInsets.only(left: 18, right: 18),
                                        decoration: BoxDecoration(color:  const Color(0xfffffde7), borderRadius: BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            const Text(
                                              "Logout",
                                              style: TextStyle(color: Colors.black, fontFamily: "medium", fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),



                                ],
                              ),
                            ),
                          )

                    ]
                ),
              ))
      ),

      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: PageView.builder(
            itemCount: widgetOptions.length,
            controller: _c,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Center(child: widgetOptions.elementAt(index));
            }),
      ),
      bottomNavigationBar: Container(
        height: Platform.isAndroid ? 70 : 100,
        padding: const EdgeInsets.all(8),
        child: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: const Color(0xfffffde7),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6.0,
                      children: [
                        _selectedIndex == 0
                            ? Column(
                          children: [
                            ImageIcon(
                              Image.asset('assets/home_active.png')
                                  .image,
                              size: 24.0,
                            ),

                          ],
                        )
                            : ImageIcon(
                          Image.asset('assets/home_inactive.png')
                              .image,
                          size: 24.0,
                        ),
                        _selectedIndex == 0
                            ? const Text(
                          '',
                          style: TextStyle(fontSize: 14.0),
                        )
                            : const Text(''),
                      ],
                    ),
                    label: "",
                  ),

                  BottomNavigationBarItem(
                    icon: _selectedIndex == 1
                        ? Image.asset('assets/student_active.png',height: 45,width: 45,)
                        : Image.asset('assets/student_inactive.png',height: 45,width: 45,),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: _selectedIndex == 2
                        ? Image.asset('assets/person_active.png',height: 45,width: 45,)
                        : Image.asset('assets/person_inactive.png',height: 45,width: 45,),
                    label: "",
                  ),
                ],
                currentIndex: _selectedIndex,
                showUnselectedLabels: false,
                selectedLabelStyle: const TextStyle(fontSize: 0.0),
                unselectedLabelStyle: const TextStyle(fontSize: 0.0),
                unselectedIconTheme:
                const IconThemeData(color: Colors.black, size: 20.0),
                selectedIconTheme: const IconThemeData(color: Colors.black),
                onTap: _onItemTapped,
                backgroundColor: const Color(0xfffffde7),
                // backgroundColor: Colors.black,
                fixedColor: const Color(0xfffffde7),
              ),
            ),
          ),
        ),
    ),
    );

  }
}