import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_flutter_practical/core/utils/widgets/styling/app_theme_data.dart';
import 'package:post_flutter_practical/features/feat_posts/bloc/post_bloc.dart';
import 'package:post_flutter_practical/features/feat_posts/screens/media_page.dart';
import 'package:post_flutter_practical/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PostBloc>()..add(const GetPostsEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media App',
      theme: AppThemesData.themeData[AppThemeEnum.LightTheme]!,
      home: const MediaPage(),
    );
  }
}
