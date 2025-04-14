import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final bool savedFavorite;
  final VoidCallback onPressed;
  const FavoriteButtonWidget({
    super.key,
    this.savedFavorite = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          savedFavorite ? Icons.favorite : Icons.favorite_border_outlined,
          color: Colors.red,
        ),
      ),
    );
  }
}
