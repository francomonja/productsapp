import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../constants/app_colors.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    Widget content = request.data ?? const SizedBox.shrink();
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(30),
        child: ListView(
          shrinkWrap: true,
          children: [
            Visibility(
              visible: request.title != null,
              child: Column(
                children: [
                  Text(
                    request.title ?? '',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            content,
            const SizedBox(width: 10),
            Visibility(
              visible: request.mainButtonTitle != null,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.blue;
                })),
                child: Text(
                  request.mainButtonTitle ?? '',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  completer(DialogResponse(confirmed: true));
                },
              ),
            ),
            Visibility(
              visible: request.secondaryButtonTitle != null,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  return Colors.blue;
                })),
                child: Text(
                  request.secondaryButtonTitle ?? '',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  completer(DialogResponse(confirmed: false));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
