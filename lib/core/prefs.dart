import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static const String onBoardingKey = "onboarding_done";

  static Future<bool> inOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onBoardingKey) ?? false;
  }
  static Future<void> setOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onBoardingKey, true);
  }

  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(onBoardingKey);
  }
}