import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showDialogDone(BuildContext context){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          actionsPadding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 40
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Column(
            children: [
              Icon(
                Icons.check_circle,
                color: Color(0xFF3D5CFF),
                size: 120,
              ),
              SizedBox(height: 5,),
              Text("Success",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
          content: Text("Congratulations, you have completed your registration!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Color(0xFF3D5CFF),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 3,
                    shadowColor: Colors.white.withOpacity(0.8),
                  ),
                  child: Text("Done")
              ),
            )
          ],
        );
      }
  );
}