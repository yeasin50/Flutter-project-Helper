import 'package:flutter/material.dart';


/// ```
///  SizedBox.square(
///               dimension: squareSize,
///               child: UserAvatarWidget(
///                 imagePath: 'assets/images/image01.png',
///                 onChangeButtonTap: () {},
///               ),
///             )
/// ```
class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    Key? key,
    required this.imagePath,
    this.isLocalImage = true,
    required this.onChangeButtonTap,
  }) : super(key: key);

  final String imagePath;
  final bool isLocalImage;
  final VoidCallback onChangeButtonTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
              ),
              child: isLocalImage
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),

        ///background circle, you also do it on image widget
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 5, color: Colors.green),
          ),
        ),

        Positioned(
          top: -12, // half of icon size
          left: 0,
          right: 0,
          child: InkWell(
            onTap: onChangeButtonTap,
            customBorder: const CircleBorder(),
            child: Container(
              width: 24 + 12, //icon size+padding
              height: 24 + 12,
              alignment: Alignment.center,

              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.green,
              ),
              child: const Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
