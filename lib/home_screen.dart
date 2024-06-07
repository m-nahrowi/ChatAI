import 'package:chat_ai/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
        model: 'gemini-pro', apiKey: const String.fromEnvironment('api_key'));
    _chatSession = _model.startChat();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat AI'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              final Content content = _chatSession.history.toList()[index];
              final text = content.parts
                  .whereType<TextPart>()
                  .map<String>((e) => e.text)
                  .join('');

              return MessageWidget(
                text: text,
                isFromUser: content.role == 'user',
              );
            }
            )
            ),
            Padding(padding: EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 15
            ),
            child: Row(
              children: [
                Expanded(child: TextField(
                  autofocus: true,
                  focusNode: _textFieldFocus,
                  decoration: textFieldDecoration(),
                  controller: _textController()
                  onSubmitted: _sendChatMessage(),
                ))
              ],
            ),
            )
          ],
        )
        );
  }

  InputDecoration textFieldDecoration() {
    return InputDecoration(
      
    )
  }
}
