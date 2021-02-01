/*

This Part of code does not work but it needs some time and attention to solve



Thank you for understanding


*/

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';


class SpeechScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: speechToText(),
    );
  }
}

class speechToText extends StatefulWidget {
  @override
  _speechToTextState createState() => _speechToTextState();



}

class _speechToTextState extends State<speechToText> {
  String outputText = '';
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  String _currentLocalId = 'en_MY';
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  double level = 0.0;
  @override
  void initState(){
    super.initState();
    initSpeechState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech To Text'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        FloatingActionButton(
        onPressed: () {
          !_hasSpeech || speech.isListening ? null : startListening();
      },
        child: Icon(Icons.mic_none,
        color: speech.isListening ? Colors.redAccent : Colors.black,),

        ),
            Text(
              outputText
            )
          ],
        ),
      ),


    );
  }

  void initSpeechState() async{
    bool hasSpeech = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener
    );
    if(!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }
  void statusListener(String status) {
    print(status);
  }

  void errorListener(SpeechRecognitionError errorNotification ) {
    print(errorNotification);
  }

  startListening() {
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: 10),
      localeId: _currentLocalId,
      onSoundLevelChange: soundLevelListener,
      cancelOnError: true,
      partialResults: true,
      onDevice: true,
      listenMode: stt.ListenMode.confirmation
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    if(result.finalResult)
      setState(() {
        outputText= result.recognizedWords;
      });
  }

  soundLevelListener(double level) {

    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }
}