import 'dart:io';
import 'package:flutter/material.dart';

class OutputScreen extends StatelessWidget {
  final String description;
  final String sponsors;
  final String filePath;

  const OutputScreen({
    required this.description,
    required this.sponsors,
    required this.filePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🪄 AI Magic Description")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.file(
                File(filePath),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all()),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nulla sed dui cursus magna venenatis bibendum. Duis vel blandit turpis. Aliquam neque dui, malesuada nec viverra et, elementum et est. Morbi consectetur ligula vel nibh molestie, vel porta quam commodo. Aenean fermentum dolor ex, id condimentum tellus vulputate quis. Cras sagittis elit vitae sapien vestibulum, rhoncus dapibus dolor porta. Praesent ipsum lacus, congue ac scelerisque mollis, pretium ac neque. Morbi id tellus eu elit viverra placerat. Pellentesque sodales justo ac aliquet placerat. Nunc est mauris, mattis vel tortor in, fermentum fringilla sapien. Maecenas in tincidunt mi. Phasellus vitae dapibus lacus. Curabitur posuere quam vitae nisi cursus, a vehicula massa lacinia. Curabitur odio nisl, fermentum in volutpat nec, scelerisque a felis.\nNulla sed dui cursus magna venenatis bibendum. Duis vel blandit turpis. Aliquam neque dui, malesuada nec viverra et, elementum et est. Morbi consectetur ligula vel nibh molestie, vel porta quam commodo. Aenean fermentum dolor ex, id condimentum tellus vulputate quis. Cras sagittis elit vitae sapien vestibulum, rhoncus dapibus dolor porta. Praesent ipsum lacus, congue ac scelerisque mollis, pretium ac neque. Morbi id tellus eu elit viverra placerat. Pellentesque sodales justo ac aliquet placerat. Nunc est mauris, mattis vel tortor in, fermentum fringilla sapien. Maecenas in tincidunt mi. Phasellus vitae dapibus lacus. Curabitur posuere quam vitae nisi cursus, a vehicula massa lacinia. Curabitur odio nisl, fermentum in volutpat nec, scelerisque a felis.",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
