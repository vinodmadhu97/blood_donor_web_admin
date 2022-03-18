import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          fillColor: Constants.appColorWhite,
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(Constants.defaultPadding * 0.75),
              margin: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding / 2),
              decoration: const BoxDecoration(
                color: Constants.appColorBrownRed,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
          ),
        ),
      ),
    );
  }
}
