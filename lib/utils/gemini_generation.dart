import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gemini_influencer_app/main.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String?> generate(
  String imagePath,
  String description,
  String sponsors,
) async {
  final model = GenerativeModel(
    model: 'gemini-1.0-pro-vision-latest',
    apiKey: geminiApiKey,
  );

  final generationConfig = GenerationConfig(
    temperature: 0.4,
  );

  final safetySettings = [
    SafetySetting(
      HarmCategory.harassment,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.hateSpeech,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.sexuallyExplicit,
      HarmBlockThreshold.medium,
    ),
    SafetySetting(
      HarmCategory.dangerousContent,
      HarmBlockThreshold.medium,
    ),
  ];

  final compressedImage = await compressImageAndConvertToPng(imagePath);

  if (compressedImage == null) {
    throw Exception("Error while compressing image");
  }

  final imageData = await compressedImage.readAsBytes();

  final sponsorsList = sponsors.split(',');

  final content = [
    Content.multi([
      DataPart('image/webp', imageData),
      TextPart(
        """Create a post to be used on a Social Media website based on the previous image. 
          The post should include the following "$description, and the sponsors are ${sponsorsList.map((sponsor) => "'$sponsor', ")}. 
          The post should include the sponsors in its content, in a way that doesn't feel like an ad.
          Add a set of tags to help promote the post at the end of the description, including all the sponsors. 
          There is a strict limit of 500 characters for the description.""",
      ),
    ])
  ];

  final response = await model.generateContent(
    content,
    safetySettings: safetySettings,
    generationConfig: generationConfig,
  );

  return response.text;
}

Future<XFile?> compressImageAndConvertToPng(String filePath) async {
  try {
    final File file = File(filePath);
    final String targetPath =
        p.join((await getTemporaryDirectory()).path, 'compressed.webp');

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
      format: CompressFormat.webp,
    );

    return compressedFile;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
