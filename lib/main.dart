import 'package:dark_mode_theme_extension/themes/dark_theme.dart';
import 'package:dark_mode_theme_extension/themes/light_theme.dart';
import 'package:dark_mode_theme_extension/themes/theme_helpers.dart';
import 'package:dark_mode_theme_extension/themes/theme_mode_cubit.dart';
import 'package:dark_mode_theme_extension/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeModeCubit(),
      child: BlocBuilder<ThemeModeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.light().copyWith(extensions: [lightThemeColors]),
            darkTheme: ThemeData.dark().copyWith(extensions: [darkThemeColors]),
            home: const MyHomePage(),
            themeMode: state,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.designSystemsColors;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text('Design System with Dark Theme'),
      ),
      body: Column(
        children: <Widget>[
          CustomCard(
            title: 'Title 1',
            subtitle: 'sub-title',
            content: 'This is context',
            icon: Icons.add,
          ),
          CustomCard(
            title: 'Title 2',
            subtitle: 'sub-title',
            content: 'This is context',
            icon: Icons.add,
          ),
          CustomCard(
            title: 'Title 3',
            subtitle: 'sub-title',
            content: 'This is context',
            icon: Icons.add,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Dark Mode', style: TextStyle(color: colors.title)),
              SizedBox(width: 4),
              BlocBuilder<ThemeModeCubit, ThemeMode>(
                builder: (context, state) {
                  return Switch(
                    value: state == ThemeMode.dark,
                    onChanged: (bool newValue) {
                      if (newValue) {
                        context.read<ThemeModeCubit>().updateThemeMode(
                          ThemeMode.dark,
                        );
                      } else {
                        context.read<ThemeModeCubit>().updateThemeMode(
                          ThemeMode.light,
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
