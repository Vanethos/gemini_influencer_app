import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'output_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sponsorsController = TextEditingController();
  String? _filePath;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🤖 Influencer's AI Helper")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: _pickFile,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 200.0,
                      ),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: _filePath == null
                            ? const Center(child: Text("Tap to select image"))
                            : Image.file(File(_filePath!)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(hintText: "Description"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _sponsorsController,
                    decoration: const InputDecoration(
                        hintText: "Sponsors, separated by ','"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SafeArea(
              child: ElevatedButton(
                onPressed: _onPressedEnabled
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OutputScreen(
                            description: _descriptionController.text,
                            sponsors: _sponsorsController.text,
                            filePath: _filePath!,
                          ),
                        ));
                      }
                    : null,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Generate",
                      style: Theme.of(context).textTheme.titleLarge?.apply(
                            color: Colors.white,
                            fontWeightDelta: 2,
                          ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _onPressedEnabled =>
      _descriptionController.text.isNotEmpty &&
      _sponsorsController.text.isNotEmpty &&
      _filePath != null;
}
