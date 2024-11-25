import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveCircularProgressIndicator extends StatelessWidget {
  final double radius; // Only used for iOS progress indicator.
  final double strokeWidth; // Only used for non-iOS progress indicator.

  const AdaptiveCircularProgressIndicator({
    super.key,
    this.radius = 20.0,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoActivityIndicator(radius: this.radius);
    }
    return CircularProgressIndicator(strokeWidth: strokeWidth);
  }
}
