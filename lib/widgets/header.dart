import 'package:blood_donor_web_admin/constants/responsive.dart';
import 'package:blood_donor_web_admin/widgets/profile_card.dart';
import 'package:blood_donor_web_admin/widgets/search_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: (){print("icon menu");}/*context.read<MenuController>().controlMenu,*/
          ),
        if (!Responsive.isMobile(context))
          Text(
            "",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
          Expanded(child: SearchField()),
         //ProfileCard()
        Text("")
      ],
    );
  }
}



