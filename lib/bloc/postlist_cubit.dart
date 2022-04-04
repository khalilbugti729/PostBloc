import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import 'postlist_state.dart';

class PostListCubit extends Cubit<PostListState> {
  PostListCubit() : super(PostListState(list: []));

  void adding(PostModel text) {
    List<PostModel> alist = state.list;
    alist.add(text);
    emit(PostListState(list: alist));
  }
  void delete(int index) {
    List<PostModel> alist = state.list;
    alist.removeAt(index);
    emit(PostListState(list: alist));
  }
}