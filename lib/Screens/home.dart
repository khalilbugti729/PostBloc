import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/bloc/postlist_cubit.dart';
import 'package:flutter_bloc_project/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/post.dart';
import '../bloc/postlist_state.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool isLike = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<PostModel> storedList = [];
  void getStoreList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getEncodeListString = prefs.getString("list");
    if (getEncodeListString != null) {
      List<PostModel> getStoredList = PostModel.decode(getEncodeListString);
      setState(() {
        storedList = getStoredList;
      });
    }
  }

  @override
  void initState() {
    getStoreList();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post App')),
      body: BlocBuilder<PostListCubit, PostListState>(
        builder: (context, count) => SafeArea(
            child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'name',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'age',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      PostModel postModel = PostModel(
                          isLike: false,
                          age: int.parse(_ageController.text),
                          name: _nameController.text);
                      context.read<PostListCubit>().adding(postModel);
                      FocusScope.of(context).unfocus();

                      _nameController.clear();
                      _ageController.clear();
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Color.fromARGB(255, 201, 92, 29).withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Center(child: Text("POST")),
                    ),
                  )
                ],
              ),
            ),
            count.list.isEmpty
                ? storedList.isEmpty
                    ? const Center(child: Text("No Data Found"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: storedList.length,
                        itemBuilder: ((context, index) {
                          return Post(
                            likePressed: (() {
                              FocusScope.of(context).unfocus();
                              context.read<PostListCubit>().like(index);
                            }),
                            myColor: index.isOdd
                                ? Color.fromARGB(255, 146, 238, 71)
                                : Color.fromARGB(255, 206, 49, 109),
                            postModel: storedList[index],
                            whenPressed: () {
                              FocusScope.of(context).unfocus();
                              context.read<PostListCubit>().delete(index);
                            },
                          );
                        }))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: count.list.length,
                    itemBuilder: ((context, index) {
                      return Post(
                        likePressed: (() {
                          FocusScope.of(context).unfocus();
                          context.read<PostListCubit>().like(index);
                        }),
                        myColor: index.isOdd
                            ? Color.fromARGB(255, 146, 238, 71)
                            : Color.fromARGB(255, 206, 49, 109),
                        postModel: count.list[index],
                        whenPressed: () {
                          FocusScope.of(context).unfocus();
                          context.read<PostListCubit>().delete(index);
                        },
                      );
                    })),
          ],
        )),
      ),
    );
  }
}
