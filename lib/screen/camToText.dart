import 'package:note/screen/widget/text_recognition_widget.dart';

import 'package:flutter/material.dart';

class TextRecognition extends StatelessWidget {
  final String title = 'Text Recognition';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(primarySwatch: Colors.blue),
    home: TextRecog(title: title),
  );
}

class TextRecog extends StatefulWidget {
  final String title;

  const TextRecog({
    @required this.title,
  });

  @override
  _TextRecogState createState() => _TextRecogState();
}

class _TextRecogState extends State<TextRecog> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(height: 25),
          TextRecognitionWidget(),
          const SizedBox(height: 15),
        ],
      ),
    ),
  );
}
