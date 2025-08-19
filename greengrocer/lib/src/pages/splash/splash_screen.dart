import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c){
        return const SignInScreen();
      }));
    } );
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor.shade400,
              CustomColors.customSwatchColor.shade500,
              CustomColors.customSwatchColor.shade600,
              CustomColors.customSwatchColor.shade700,
              CustomColors.customSwatchColor.shade800,
              CustomColors.customSwatchColor.shade900,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNameWidget(
              greenTitleColor: Colors.white, 
              textSize: 40,
            ),

            SizedBox(height: 10,),

            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
          ],
        ),

      ),
    );
  }
}