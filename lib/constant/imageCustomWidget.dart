import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedProfileImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const CachedProfileImage(
      {Key? key, required this.imageUrl, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: appSize.height * 0.0),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: imageUrl.isNotEmpty // Check if imageUrl is not empty
            ? ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(10000.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  placeholder: (context, url) => Container(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/avatar.png',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              )
            : Image.asset(
                'assets/images/avatar.png',
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
      ),
    );
  }
}


class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  FullScreenImagePage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close full-screen image on tap
      },
      child: Scaffold(
        body: Center(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain, // Use BoxFit.contain to fit the image within the screen
            placeholder: (context, url) => CircularProgressIndicator(), // Show a loader while loading
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red), // Error widget in case the image fails to load
          ),
        ),
      ),
    );
  }}