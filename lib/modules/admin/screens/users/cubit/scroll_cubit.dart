import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';

// abstract class ScrollStates {}
//
// class InitialScrollState extends ScrollStates {}
//
// class EndPageFalseState extends ScrollStates {}
//
// class EndPageTrueState extends ScrollStates {}

class ScrollCubit extends Cubit<bool> {
  final ScrollController _scrollController = ScrollController();
  // final double? screenHeight;
  ScrollCubit() : super(false) {
    _scrollController.addListener(_scrollListener);
  }

  static ScrollCubit get(context) => BlocProvider.of(context);

  ScrollController get scrollController => _scrollController;

  void _scrollListener() {
    //checks if I have scrolled at the end of the list or/ the page,
    // bool condition = screenHeight == null
    //     ? (_scrollController.position.maxScrollExtent ==
    //         _scrollController.offset)
    //     : (_scrollController.position.pixels >=
    //         _scrollController.position.maxScrollExtent);
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
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
