import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/models/post_model.dart';

class Post extends StatelessWidget {
  final PostModel postModel;
  final Color? myColor;
  final Function()? whenPressed;
  final Function()? likePressed;
  const Post(
      {Key? key,
      required this.postModel,
      required this.likePressed,
      required this.whenPressed,
      required this.myColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(22),
      height: 120,
      decoration: new BoxDecoration(
        color: myColor,
        borderRadius: new BorderRadius.circular(25),
      ),
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    postModel.name,
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    postModel.age.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: whenPressed,
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 255, 255, 255),
                )),
            IconButton(
                onPressed: likePressed,
                icon: Icon(
                  Icons.thumb_up,
                  color:postModel.isLike? Color.fromARGB(255, 76, 52, 212):Color.fromARGB(255, 255, 255, 255),
                ))
          ],
        ),
      ),
    );
  }
}
