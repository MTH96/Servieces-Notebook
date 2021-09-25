import 'package:flutter/material.dart';

class EditBox extends StatelessWidget {
  const EditBox(
      {Key? key,
      required this.onPress,
      required this.child,
      this.height,
      this.width})
      : super(key: key);

  final Function() onPress;
  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
        ),
      child: GridTile(
        footer: GestureDetector(
          child: const GridTileBar(
            backgroundColor: Colors.black45,
            leading: Text('edit',style: TextStyle(color: Colors.white),),
            
            subtitle:  Icon(Icons.edit),
          ),
          onTap: onPress,
        ),
        child: child,
      ),
    );
  }
}
