import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:radiocucei/src/services/notificaciones_service.dart';

class SubscriptionTile extends StatefulWidget {
  final Widget child;
  final int index;
  const SubscriptionTile({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  State<SubscriptionTile> createState() => _SubscriptionTileState();
}

class _SubscriptionTileState extends State<SubscriptionTile> {
  bool _isBlur = false;

  @override
  Widget build(BuildContext context) {
    final notificationService = Provider.of<NotificationsService>(context);
    final program = notificationService.programas[widget.index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
          key: const Key('0'),
          endActionPane: ActionPane(motion: const DrawerMotion(), children: [
            SlidableAction(
              onPressed: (BuildContext context) async {
                final resp =
                    await notificationService.unSubscribe(widget.index);

                (resp)
                    ? ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Haz cancelado la subscripcion a ${program.nombrePrograma}'),
                          duration: const Duration(milliseconds: 800),
                          action: SnackBarAction(
                              label: 'Ocultar',
                              onPressed: ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar),
                        ),
                      )
                    : null;
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
