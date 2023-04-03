import 'package:text_to_speech/text_to_speech.dart';

class TextToSpeechConvertor {
  final TextToSpeech _tts = TextToSpeech();

  double volume = 1; // Range: 0-1
  double rate = .7; // Range: 0-2
  double pitch = 1.0; // Range: 0-2

  Future speak(String text) async {
    _tts.setVolume(volume);
    _tts.setRate(rate);
    _tts.setLanguage("en-US");

    _tts.setPitch(pitch);
    await _tts.speak(text);
  }
}
