import 'dart:convert';
import 'dart:math';
import 'dart:convert';
import 'package:curious/screens/WebView.dart';
import 'package:http/http.dart' as http;

import 'package:curious/video/methods.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
    sendmeet(roomName);
  }
  sendmeet(String link) async {
    final url = Uri.parse('https://9loc20ibh8.execute-api.us-east-1.amazonaws.com/api/client/sendmeet');

    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "link": "https://meet.jit.si/$link",
          }));

      print(url);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            'Start A New Meet And Invite Others',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){
              createNewMeeting();

            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Create A New Meeting',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            text: 'Mute Audio',
            isMute: isAudioMuted,
            onChange: onAudioMuted,
          ),
          MeetingOption(
            text: 'Turn Off My Video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}





class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOption({
    Key? key,
    required this.text,
    required this.isMute,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(
            value: isMute,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}


class ApiService {
  Future<List<UrlData>> fetchData() async {
    final response = await http.get(Uri.parse('https://9loc20ibh8.execute-api.us-east-1.amazonaws.com/api/client/getmeet'));
    if (response.statusCode == 200) {
      final parsedResponse = json.decode(response.body);
      List<dynamic> urls = parsedResponse['urls'];
      return urls.map((url) => UrlData.fromJson(url)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}

class UrlData {
  final String id;
  final String link;

  UrlData({
    required this.id,
    required this.link,
  });

  factory UrlData.fromJson(Map<String, dynamic> json) {
    return UrlData(
      id: json['_id'],
      link: json['link'],
    );
  }
}








class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: FutureBuilder<List<UrlData>>(
          future: apiService.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return UrlCard(urlData: snapshot.data![index]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

    );
  }
}

class UrlCard extends StatelessWidget {
  final UrlData urlData;

  UrlCard({required this.urlData});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Container(
          child: Text("Connect With Others",  style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,),
        ),

        Card(
        margin: EdgeInsets.all(16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
            onTap: (){

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewExample(
                        url: urlData.link,
                      )));
            },
          child: ListTile(
            leading: Icon(Icons.link),
            title: Text(urlData.link),
          ),
        ),
      ),
    ]
    );
  }
}
