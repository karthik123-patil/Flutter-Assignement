import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/userlist_screen.dart';
import 'package:flutter_assignment/utils/colors.dart';

class FlashPage extends StatelessWidget {
  const FlashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.whiteColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => UserListScreen()));
                },
                child: Image.asset(
                  "assets/images/img_assignment.jpeg",
                  width: 150,
                ),
              ),
              const Text(
                "Flutter Assignment",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
