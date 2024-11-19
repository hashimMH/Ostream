import 'package:envied/envied.dart';

part 'env.g.dart'; // This will point to the generated file.

@Envied(path: '.env') // Specify the path to the `.env` file.
abstract class Env {
  @EnviedField(varName: 'OPENAI_API_KEY') // Variable name in `.env` file.
  static const String openAiApiKey = _Env.openAiApiKey; // Explicitly declare type as String.
  static const String geminiKey = _Env.GeminiApiKey; // Explicitly declare type as String.
}
