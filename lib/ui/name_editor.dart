import 'package:flutter/material.dart';

class TextEditor extends StatefulWidget {
  TextEditor(this.text, this.onChanged, {super.key});

  String? text;
  final ValueChanged<String>? onChanged;

  @override
  State<StatefulWidget> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  String? text;
  TextEditingController txt = TextEditingController();

  @override
  void initState() {
    text = widget.text;
    txt.text = text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: Theme.of(context).colorScheme.surface),
        child: Row(
          children: [
            Expanded(child:
            TextField(
                controller: txt,
                onChanged: (value) {
                  setState(() {
                    text = value;
                  });
                }),
            ),
            IconButton(
                onPressed: text == null ? null : () => widget.onChanged!(text!),
                icon: const Icon(Icons.check))
          ],
        ));
  }
}
