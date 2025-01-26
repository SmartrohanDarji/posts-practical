import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:post_flutter_practical/core/utils/widgets/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionCard extends StatelessWidget {
  final String? description;

  const DescriptionCard({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 10),
      child: LinkText(
        description ?? '',
        onLinkTap: (url) async {
          if (!await launchUrl(Uri.parse(url))) {
            throw Exception('Could not launch $url');
          }
        },
        textStyle: const TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        linkStyle: const TextStyle(
          fontSize: 14,
          color: AppColors.primaryColor,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
