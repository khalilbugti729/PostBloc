import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import 'postlist_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit() : super(PostListState(list: []));

  void storeList(List<PostModel> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodeListString = PostModel.encode(list);
    await prefs.setString("list", encodeListString);
  }

  void adding(PostModel text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getEncodeListString = prefs.getString("list");
    if (getEncodeListString == null) {
      List<PostModel> alist = state.list;
      alist.add(text);
      emit(PostListState(list: alist));
      storeList(alist);
    } else {
      List<PostModel> storedList = PostModel.decode(getEncodeListString);
      storedList.add(text);
      emit(PostListState(list: storedList));
      storeList(storedList);
    }
  }

  void like(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getEncodeListString = prefs.getString("list");
    if (getEncodeListString == null) {
      List<PostModel> alist = state.list;
      alist[index].isLike = !alist[index].isLike;
      emit(PostListState(list: alist));
      storeList(alist);
    } else {
      List<PostModel> storedList = PostModel.decode(getEncodeListString);
      storedList[index].isLike = !storedList[index].isLike;
      emit(PostListState(list: storedList));
      storeList(storedList);
    }
  }

  void delete(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? getEncodeListString = prefs.getString("list");
    if (getEncodeListString == null) {
      List<PostModel> alist = state.list;
      alist.removeAt(index);
      emit(PostListState(list: alist));
      storeList(alist);
    } else {
      List<PostModel> storedList = PostModel.decode(getEncodeListString);
      storedList.removeAt(index);
      emit(PostListState(list: storedList));
      storeList(storedList);
    }
  }
}
