import 'package:flutter/material.dart';

class HeroImageWidget extends StatelessWidget {
  final String url;
  const HeroImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: url,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
