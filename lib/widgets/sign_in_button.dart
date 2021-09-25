import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.ctx,
    required this.label,
    required this.icon,
    required this.onPress,
  }) : super(key: key);
  final BuildContext ctx;
  final Widget label;
  final void Function() onPress;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPress,
      icon: icon,
      label: FittedBox(child:label , fit: BoxFit.scaleDown,)
      ,
      style: TextButton.styleFrom(
          backgroundColor: Theme.of(ctx).colorScheme.primary,
          fixedSize: Size(MediaQuery.of(ctx).size.width * 0.7, 40.0),
          side: BorderSide(
              color: Theme.of(ctx).colorScheme.secondary,
              width: 1,
              style: BorderStyle.solid),
          elevation: 2,
          primary: Colors.white),
    );
  }
}
