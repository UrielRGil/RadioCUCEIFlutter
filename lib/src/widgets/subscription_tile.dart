import 'dart:ui';

import 'package:flutter/material.dart';

class SusbscriptionTile extends StatefulWidget {
  final Widget child;

  const SusbscriptionTile({Key? key, required this.child}) : super(key: key);

  @override
  State<SusbscriptionTile> createState() => _SusbscriptionTileState();
}

class _SusbscriptionTileState extends State<SusbscriptionTile> {
  bool _isBlur = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isBlur = !_isBlur;
          });
        },
        child: _SubscriptionContainer(
          blur: _isBlur ? 20.0 : 0.0,
          opacity: 0.4,
          child: widget.child,
        ));
  }
}

class _SubscriptionContainer extends StatelessWidget {
  const _SubscriptionContainer({
    Key? key,
    required this.blur,
    required this.opacity,
    required this.child,
  }) : super(key: key);

  final double blur;
  final double opacity;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                width: 1.5,
                color: Colors.white.withOpacity(0.2),
              )),
          child: child,
        ),
      ),
    );
  }
}
