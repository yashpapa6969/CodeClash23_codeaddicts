import 'dart:convert';
import 'dart:async';


import 'package:curious/repo/home_repo.dart';
import 'package:curious/screens/main_class.dart';
import 'package:curious/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

String URL="https://3c09-2405-201-d006-11ff-8869-36ce-a7a4-ef2a.in.ngrok.io";
class AuthProvider with ChangeNotifier {
  String token = '';
  String _id = '';
  String student_id = '';
  String institute_id = '';
  String course = '';


  String type = '';
  String phone = '';
  String email = '';
  String langId = '';
  String catId = '';
  String message = '';
  String name = '';
  String otp = '';
  String studentName = '';
  String selected_country_code = '+91';
  String image = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String verificationid = '';


  // final HomeRepository _homeRepo = HomeRepository();
  //   HomeRepository get homeRepo => _homeRepo;
  int status = 0;
  bool mobileError = false;
  bool loading = false;
  bool otpError = false;
  bool nameError = false;


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  final SharedPrefrence _saveData = SharedPrefrence();

  SharedPrefrence get saveData => _saveData;

  bool get isAuth {
    // ignore: avoid_print
    return _id.isNotEmpty && type != "register";
  }

  String get _token {
    if (token.isNotEmpty) {
      return token;
    }
    return '';
  }


  String get userId {
    return _id;
  }

  void updatePhone(String value) {
    phone = value;
  }

  void updatevid(String value) {
    verificationid = value;
  }

  void updateLoginStatus(int value, BuildContext context) {
    if (value == 0) {
      // Navigator.popAndPushNamed(
      //   context,
      //   Login.routeName,
      // );
    } else {
      // Navigator.popAndPushNamed(
      //   context,
      //   Otp.routeName,
      // );
    }

    // notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final saveData = await SharedPreferences.getInstance();
    if (!saveData.containsKey('student_id')) {
      return false;
    }
    print(saveData.getString("student_id"));
    student_id = saveData.getString("student_id")!;
    notifyListeners();
    return true;
  }


  final HomeRepository _homeRepo = HomeRepository();

  HomeRepository get homeRepo => _homeRepo;


  String gender = "Select Gender";

  final TextEditingController _nameController = TextEditingController();


  TextEditingController get nameController => _nameController;


  final TextEditingController _usnController = TextEditingController();


  TextEditingController get usnController => _usnController;


  String profileImage = '';
  String user = 'Teacher';
  String city_id = "0";
  bool emailError = false;
  bool cityNameError = false;
  bool passwordError = false;




  register(BuildContext context) async {

    await _homeRepo
        .register(
      nameController.text,
      emailController.text,
      passwordController.text,
      usnController.text,



    )
        .then((response) async {
      final responseData = json.decode(response);
      print(responseData);
      print(responseData["message"]);
      _showDialog(responseData["message"], context);

    });

    notifyListeners();
  }
  login(BuildContext context) async {

    await _homeRepo.login(
      emailController.text,
      passwordController.text,
    )
        .then((response) async {
      final responseData = json.decode(response);
      print(responseData);
      print(responseData["message"]);
      _showDialog(responseData["message"], context);

    });

    notifyListeners();
  }

  void _showDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('CuriosityHub!'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size.fromHeight(40.0)),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
            child: const Text('Okay'),
            onPressed: () {
              nameController.text = "";
              emailController.text = "";
              passwordController.text="";
              usnController.text = '';

              notifyListeners();
              Navigator.of(ctx).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));

            },
          )
        ],
      ),
    );
  }






//f (response.statusCode == 200) {
//         var responseBody = response.body;
//         final responseData = json.decode(response.body);
//         print(responseData);
//         status1 = true;
//
//         Fluttertoast.showToast(
//             msg: responseBody,
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.black,
//             fontSize: 16.0
//         );
//
//       } else {
//         print('Request failed with status: ${response.statusCode}.');
//       }
//     } catch (error) {
//       print('Error making POST request: $error');
//     } finally {
//       // Close the client
//       client.close();
//     }


}
