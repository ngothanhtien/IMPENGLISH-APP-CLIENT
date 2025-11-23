import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../../core/prefs.dart';
class Onboarding_Screen extends StatefulWidget{
  static const String routeName = '/onboarding';
  @override
  State<Onboarding_Screen> createState() => _Onboarding_Screen();
}
class _Onboarding_Screen extends State<Onboarding_Screen>{
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(BuildContext context) async {
    await Prefs.setOnboardingDone();
    if(!mounted) return;
    context.go('/');
  }
  Widget _buildIllustration(String logoPath,
  {
    double w = 320,
    double h = 320
  }){
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset(
              logoPath,
            fit: BoxFit.fill,
            width: w,
            height: h,
          ),
          SizedBox(height: 10,),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      imageFlex: 2,
      bodyFlex: 2,
      titleTextStyle: TextStyle(fontSize: 33, fontWeight: FontWeight.bold, color: Colors.black),
      bodyTextStyle: TextStyle(fontSize: 16.0),
      contentMargin: EdgeInsets.symmetric(horizontal: 16,vertical: 40),
      imagePadding: EdgeInsets.only(bottom: 20),
      titlePadding: EdgeInsets.only(top: 20),
      pageColor: Colors.white,
    );
    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: "Do you want to improve your English?",
              bodyWidget: Column(
                children: [
                  SizedBox(height: 30,),
                  const Text("From Beginner to Fluent, Together.",
                    style: TextStyle(
                      color: Color(0xFF858597),
                      fontSize: 16,
                      height: 1.5
                    ),
                  ),
                ],
              ),
              image: _buildIllustration("assets/images/logos/logo_app2.jpg"),
            decoration: pageDecoration,
          ),
          PageViewModel(
              title: "Quick and easy learning",
              bodyWidget: const Column(
                children: [
                   SizedBox(height: 30,),
                   Text("Easy and fast learning at any time to help you improve "
                      "various" " skills",
                  style: TextStyle(
                    color: Color(0xFF858597),
                    fontSize: 16,
                    height: 1.5
                  ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              image: _buildIllustration("assets/images/logos/logo_app2.jpg"),
              decoration: pageDecoration,
          ),
          PageViewModel(
            title: 'Create your own study plan',
            bodyWidget: const Column(
              spacing: 4,
              children: [
                SizedBox(height: 30,),
                Text("Study according to the"
                    " study plan, make study"
                    " more motivated",
                  style: TextStyle(
                    color: Color(0xFF858597),
                    fontSize: 16,
                    height: 1.5
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            decoration: pageDecoration,
            footer: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150 ,
                    child: ElevatedButton(
                        onPressed: () => context.go('/register'),
                        child: const Text("Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3D5CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  SizedBox(
                    height: 40,
                    width: 150 ,
                    child: ElevatedButton(
                      onPressed: () => context.go('/login'),
                      child: const Text("Log in",
                        style: TextStyle(
                          color: Color(0xFF3D5CFF),
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                          ),
                        side: BorderSide(color: Color(0xFF3D5CFF),width: 1.5)
                      ),
                    ),
                  )
                ],
              )
            ),
            image: _buildIllustration("assets/images/logos/logo_app2.jpg",h: 250,w: 280),
          ),
        ],
        showSkipButton: true,
        skip: const Text('Skip',style: TextStyle(fontSize: 16,color: Color(0xFF858597),fontWeight: FontWeight.bold),),
        next: const Icon(Icons.arrow_forward,size: 24,color: Color(0xFF858597),),
        done: const Text('Done', style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.w600)),

        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        dotsDecorator: DotsDecorator(
          size: const Size(10, 7),
          activeSize: const Size(40, 8),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          spacing: const EdgeInsets.symmetric(horizontal: 5),
          activeColor: Color(0xFF3D5CFF)
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        animationDuration: 360,
      ),
    );
  }
}