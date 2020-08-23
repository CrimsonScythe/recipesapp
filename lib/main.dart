import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/authentication/authentication_bloc.dart';
import 'package:recipes/src/blocs/authentication/authentication_event.dart';
import 'package:recipes/src/blocs/authentication/authentication_state.dart';
import 'package:recipes/src/blocs/bloc_observer.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_bloc.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/models/shoppinglist.dart';
import 'package:recipes/src/screens/app_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(RootListAdapter());
  Hive.registerAdapter(ShoppingListAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AuthenticationBloc(),
        child: MyHomePage(),
    )
    );
  }
}

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Unknown) {
          BlocProvider.of<AuthenticationBloc>(context).add(LogInRequestedAnon());
          return Center(child: CircularProgressIndicator(),);
        }
        if (state is Authenticated) {
          return BlocProvider(
              create: (_) => BottomNavBloc(),
              child: AppScreen()
          );
        }
        return Text('Error');
      },
    );
//    return BlocProvider(
//      create: (_) => BottomNavBloc(),
//      child: AppScreen()
//    );
  }
}
