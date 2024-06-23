import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// abstract class ScrollStates {}
//
// class InitialScrollState extends ScrollStates {}
//
// class EndPageFalseState extends ScrollStates {}
//
// class EndPageTrueState extends ScrollStates {}

class ScrollCubit extends Cubit<bool> {
  final ScrollController _scrollController = ScrollController();

  ScrollCubit() : super(false) {
    _scrollController.addListener(_scrollListener);
  }

  static ScrollCubit get(context) => BlocProvider.of(context);

  ScrollController get scrollController => _scrollController;

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      emit(true);
    } else {
      emit(false);
    }
  }

  @override
  Future<void> close() {
    _scrollController.dispose();
    return super.close();
  }
}
