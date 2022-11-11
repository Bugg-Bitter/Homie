import 'package:flutter/material.dart';

class UIBanner extends StatelessWidget {
  const UIBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'asset/search/banner.png',
    );
  }
}
