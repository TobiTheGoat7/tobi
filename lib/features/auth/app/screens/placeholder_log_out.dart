import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/services/authmanager/authmanager.dart';

class PlaceHolderLogOut extends StatelessWidget {
  const PlaceHolderLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          text: "Log out",
          onPressed: () async {
            await AuthManager.instance.clearAuthenticatedUser();
            // ignore: use_build_context_synchronously
            GoRouter.of(context).go("/");
          },
        ),
      ),
    );
  }
}
