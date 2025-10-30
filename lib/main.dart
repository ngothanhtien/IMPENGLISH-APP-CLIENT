import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learning_app_client/component/fadetransition/CustomFadeTransition.dart';
import 'package:learning_app_client/component/navigation/bottom_nav_scaffold.dart';
import 'package:learning_app_client/core/prefs.dart';
import 'package:learning_app_client/presentation/screens/Onboarding/onboarding_start_run1.dart';
import 'package:learning_app_client/presentation/screens/login/login_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/community_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/community/post_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/home/home_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/learn/detail_practice_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/learn/learn_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/profile/profile_edit_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/profile/profile_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/profile/profile_setting.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_detail_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_questions_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_results_screen.dart';
import 'package:learning_app_client/presentation/screens/menu_screen/quiz/quiz_screen.dart';
import 'package:learning_app_client/presentation/screens/register/register_screen.dart';
import 'package:learning_app_client/presentation/screens/search/search_sceen.dart';
import 'package:learning_app_client/presentation/screens/verify-otp/verify_otp_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final seenOnboarding = await Prefs.inOnboardingDone();
  await dotenv.load(fileName: '.env');
  runApp(MyApp(seenOnboarding: seenOnboarding,));
}
final GoRouter _router = GoRouter(
    initialLocation: '/home',
    routes: [
      // menu item
      StatefulShellRoute.indexedStack(
        builder: (context,state,navigationShell){
          return ScaffoldWithBottomNav(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/home',
                    builder: (context,state) => const HomeScreen()
                ),
                GoRoute(
                    path: '/home/search',
                    builder: (context,state) => const SearchScreen()
                )
              ]
          ),
          StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/learning',
                    builder: (context,state) =>  LearnScreen()
                )
              ]
          ),
          StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/quiz',
                  builder: (context,state) =>  QuizScreen()
                ),
                GoRoute(
                  path: '/quiz/detail',
                  builder: (context,state)  {
                    final data = state.extra as Map<String,dynamic>;
                    final level = data['level'];
                    final category = data['category'];
                    final questions = data['questions'];
                    final timeLimit = data['timeLimit'];
                    return QuizDetailScreen(
                        level: level,
                        category: category,
                        questions: questions,
                        timeLimit: timeLimit
                    );
                  }
                ),
                GoRoute(
                  path: '/quiz/detail/practice',
                  builder: (context,state)  {
                    final data = state.extra as Map<String,dynamic>;
                    final level = data['level'];
                    final category = data['category'];
                    final questions = data['questions'];
                    final timeLimit = data['timeLimit'];
                    return QuizQuestionsScreen(
                        level: level,
                        category: category,
                        questions: questions,
                        timeLimit: timeLimit
                    );
                  }
                ),
                GoRoute(
                    path: '/quiz/detail/practice/result',
                    builder: (context,state)  {
                      final data = state.extra as Map<String,dynamic>;
                      final level = data['level'];
                      final category = data['category'];
                      final questions = data['questions'];
                      final timeLimit = data['timeLimit'];
                      final userAnswers = data['userAnswers'];
                      final quizQuestions = data['quizQuestions'];
                      return QuizResultsScreen(
                          level: level,
                          category: category,
                          questions: questions,
                          timeLimit: timeLimit,
                          userAnswers: userAnswers,
                          quizQuestions: quizQuestions
                      );
                    }
                ),
              ]
          ),
          StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/community',
                    builder: (context,state) =>  Community_Screen()
                ),
                GoRoute(
                    path: '/community/post',
                    builder: (context,state) =>  Post_Screen()
                )
              ]
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: '/profile',
                  builder: (context,state) => ProfileScreen()
              ),
              GoRoute(
                  path: '/profile/edit-profile',
                  pageBuilder: (context,state) => buildFadeTransitionPage(EditProfileScreen())
              ),
              GoRoute(
                  path: '/profile/setting',
                  pageBuilder: (context,state) => buildFadeTransitionPage(SettingScreen())
              ),
            ]
          ),
        ]
      ),
      GoRoute(
          path: '/practice',
          builder: (context,state) {
            final data = state.extra as Map<String,dynamic>;
            final vocab = data['vocab'];
            return DetailPracticeScreen(vocab: vocab,);
          }
      ),
      GoRoute(
          path: '/onboarding',
          pageBuilder: (context,state) => buildFadeTransitionPage(Onboarding_Screen())
      ),
      GoRoute(
          path: '/login',
          pageBuilder: (context,state) => buildFadeTransitionPage(LoginScreen())
      ),
      GoRoute(
          path: '/register',
          pageBuilder: (context,state) => buildFadeTransitionPage(RegisterScreen())
      ),
      GoRoute(
          path: '/verify-otp',
          pageBuilder: (context,state){
            final data = state.extra as Map<String,dynamic>;
            final email = data['email'] as String;

            return buildFadeTransitionPage(VerifyOtpScreen(email: email,));
          }
      )
    ]
);
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.seenOnboarding});

  final bool seenOnboarding;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          }
        )
      ),
    );
  }
}
