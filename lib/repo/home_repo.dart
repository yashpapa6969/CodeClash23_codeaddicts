import 'dart:convert';
import 'package:curious/utils/url.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeRepository {



  Future<String> register(String name,
      String email,
      String password,
      String usn,) async {
    final url = Uri.parse(URL.url+'register');
    print(url);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": name,
            "password": password,
            "usn": usn,
            "email": email,

          }
          ));

      print(url);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }


  Future<String> login(String emailAddress,
      String password,) async {
    final url = Uri.parse(URL.url+'login');
    print(url);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": emailAddress,
            "password": password,
          }));

      print(url);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }




  Future<String> newQuestion(
      String profileImage,
      String question,
      String tag,

      ) async {
    final url = Uri.parse(URL.url+"new_question");
    try {
      var request = http.MultipartRequest('POST', url);
      if (profileImage.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', profileImage));
      }

      request.fields['tag'] = tag;
      request.fields['question'] = question;


      var res = await request.send();
      final respStr = await res.stream.bytesToString();

      return respStr;
    } catch (error) {
      print(error);
      rethrow;
    }
  }




  Future<String> postsAnwserbyID(String questionID,
      String answer,) async {
    final url = Uri.parse(URL.url+'new_answer');
    print(url);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "question_id": questionID,
            "answer": answer,
          }));

      print(url);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }


  Future<String> AllQuestions() async {
    final url = Uri.parse(URL.url+'all_question');
    print(url);
    try {
      final response = await http.get(url);

      print(response.body);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }



  Future<String> AnwserByID(String Id) async {
    final url = Uri.parse(URL.url+'get_answers/$Id');
    print(url);
    try {
      final response = await http.get(url);

      print(response.body);

      return response.body;
    } catch (error) {
      throw (error);
    }
  }





}


