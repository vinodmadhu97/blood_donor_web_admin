import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PosterCard extends StatelessWidget {
  final String docId;
  final String url;
  final String expDate;
  const PosterCard({
    Key? key,
    required this.docId,
    required this.url,
    required this.expDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, url) => const SpinKitCircle(
              color: Constants.appColorBrownRed,
              size: 50,
            ),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/profile_avatar.jpg"),
          ),
        ),
        Text(
          "Expired on $expDate",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Constants.appColorGray),
        )
      ],
    );
  }
}
