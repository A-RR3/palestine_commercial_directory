import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/shared/network/remote/dio_helper.dart';
import 'package:videos_application/shared/network/remote/my_bloc_observer.dart';
import 'package:videos_application/permission_cubit/permission_cubit.dart';

import 'modules/videos_modules/video_player_screen.dart';

void main() {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Videos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: VideoPlayerScreen(),

      ),
    );
  }
}
