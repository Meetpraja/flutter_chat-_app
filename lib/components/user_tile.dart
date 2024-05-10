import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.text, required this.ontap, required this.img});
  final String text;
  final void Function()? ontap;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(child: Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: ClipOval(
                              child: Image.asset(img),
                            )
                        ),),
                    ),
                    // Icon(
                    //   Icons.person,
                    //   color: Theme.of(context).colorScheme.inversePrimary,
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ],
                ),
                ),
                Container(
                  height: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
