import 'dart:convert';

import 'package:curious/repo/home_repo.dart';
import 'package:flutter/material.dart';

class PostsProvider with ChangeNotifier {
  final HomeRepository _homeRepo = HomeRepository();

  HomeRepository get homeRepo => _homeRepo;

  bool tagError = false;
  bool questionError = false;
  String QuestionID='';


  TextEditingController _questionController = TextEditingController();
  TextEditingController get questionController => _questionController;
  TextEditingController _tagController = TextEditingController();

  TextEditingController get tagController => _tagController;


  TextEditingController _anwserController = TextEditingController();


  TextEditingController get anwserController => _anwserController;
  String profileImage='';

  uploadProfileImage(String filepath) async {
    profileImage = filepath;
    notifyListeners();
  }


  updateQid(String id) async {
    QuestionID = id;
    print(QuestionID);
    getAllAnwsers();
    notifyListeners();
  }

  List<Question> _TypeItems = [];

  List<Question> get TypeItems {
    return [..._TypeItems];
  }


  List<Answer> _Items = [];

  List<Answer> get Items {
    return [..._Items];
  }


  getAllQuestions() async {
    _TypeItems = [];
    await _homeRepo.AllQuestions().then((response) {
      final responseData = json.decode(response);
      responseData['questions'].forEach((prodData) {
        _TypeItems.add(Question(
          filename: prodData['filename'],
       //   ocrText: prodData['ocr_text']??'No Image',
          question: prodData['question'],
          questionId: prodData['question_id'],
          tag: prodData['tag'],));
      });
    });

    notifyListeners();
  }


  getAllAnwsers() async {
    _Items = [];
    await _homeRepo.AnwserByID(QuestionID).then((response) {
      final responseData = json.decode(response);
      responseData['answers'].forEach((prodData) {
        _Items.add(Answer(
            answer: prodData['answer'],
          questionId: prodData['question_id'], ));
      });
    });

    notifyListeners();
  }



  postQuestion(BuildContext context) async {

      await _homeRepo
          .newQuestion(
          profileImage,
        questionController.text,
        tagController.text)
          .then((response) async {
        final responseData = json.decode(response);
        print(responseData);
        print(responseData["message"]);
        _showDialog(responseData["message"], context);


      });
      notifyListeners();

  }


  postAnwser(BuildContext context) async {

    await _homeRepo
        .postsAnwserbyID(
      QuestionID,
      anwserController.text

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
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
            ),
            child: const Text('Okay'),
            onPressed: () {

              profileImage = "";
              questionController.text = '';
              tagController.text='';
              anwserController.text= '';
              notifyListeners();
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );


}
}

class Question {
  final String filename;
  //final String ocrText;
  final String question;
  final String questionId;
  final String tag;

  Question({
    required this.filename,
   // required this.ocrText,
    required this.question,
    required this.questionId,
    required this.tag,
  });


}



class Answer {
  final String answer;
  final String questionId;

  Answer({
    required this.answer,
    required this.questionId,
  });

}





