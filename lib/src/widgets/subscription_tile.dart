import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO: Revisar si es necesario utilizar el GestureDetector
//TODO: Ver que datos mostrar
class SubscriptionTile extends StatefulWidget {
  final Widget child;

  const SubscriptionTile({Key? key, required this.child}) : super(key: key);

  @override
  State<SubscriptionTile> createState() => _SubscriptionTileState();
}

class _SubscriptionTileState extends State<SubscriptionTile> {
  bool _isBlur = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
          key: const Key('0'),
          endActionPane: ActionPane(motion: const DrawerMotion(), children: [
            SlidableAction(
              onPressed: (_) {
                print('eliminar');
              },
              backgroundColor: Colors.white.withOpacity(0.0),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ]),
          child: _SubscriptionContainer(
            blur: _isBlur ? 20.0 : 0.0,
            opacity: 0.4,
            child: widget.child,
          )),
    );
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
              color: Colors.grey.withOpacity(opacity),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                width: 1.5,
                color: Colors.grey.withOpacity(0.2),
              )),
          child: child,
        ),
      ),
    );
  }
}
