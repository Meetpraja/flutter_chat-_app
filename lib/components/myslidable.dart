import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MySlidable extends StatefulWidget {
  const MySlidable(
      {
        super.key,
        required this.isCurrentUser,
        required this.child,
      });

  final bool isCurrentUser;
  final Widget child;

  State<MySlidable> createState()=> _MuSlidableState();

}
class _MuSlidableState extends State<MySlidable>{


  @override
  Widget build(BuildContext context) {


    if(widget.isCurrentUser){
      return Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            IconButton(
              onPressed:(){},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        child: widget.child,
      );
    }else{
      return Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
              onPressed:(){},
              icon: const Icon(Icons.delete),
            ),),
          ],
        ),
        child: widget.child,
      );
    }

  }
}
