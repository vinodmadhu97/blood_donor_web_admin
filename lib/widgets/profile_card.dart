
import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/responsive.dart';
import 'package:flutter/material.dart';


class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Constants.defaultPadding),
      child: Card(
        child: Container(
          padding:const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Constants.appColorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/profile_pic.png",
                height: 38,
              ),
              if (!Responsive.isMobile(context))
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: Constants.defaultPadding / 2),
                  child: Text("Angelina Jolie"),
                ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }
}