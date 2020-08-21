import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_bloc.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_event.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_state.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyRecipes_state.dart';
import 'package:recipes/src/blocs/dailyRecipes/dailyrecipes_bloc.dart';
import 'package:recipes/src/blocs/favourites/favourites_bloc.dart';
import 'package:recipes/src/blocs/shoppingscreen/shoppingscreen_bloc.dart';
import 'package:recipes/src/screens/favourites_screen.dart';
import 'package:recipes/src/screens/home_screen.dart';
import 'package:recipes/src/screens/profile_screen.dart';
import 'package:recipes/src/screens/shopping_screen.dart';


class AppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final BottomNavBloc bottomNavBloc = BlocProvider.of<BottomNavBloc>(context);
    return Scaffold(

      body: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            if (state is PageLoading) {

              return Center(child: CircularProgressIndicator(),);
            }

            if (state is HomePageLoaded) {

              return BlocProvider(
                create: (_) => DailyRecipesBloc(),
                child: HomeScreen(),
              );
              return HomeScreen();
            }
            if (state is FavouritesPageLoaded) {
              return BlocProvider(
                create: (_) => FavouritesBloc(),
                child: FavouritesScreen(),
              );
//              return FavouritesScreen();
            }
            if (state is ShoppingPageLoaded){
              return BlocProvider(
                  create: (_) => ShoppingScreenBloc(),
                  child: ShoppingScreen(),
              );
              return ShoppingScreen();
            }
            if (state is ProfilePageLoaded) {
              return ProfileScreen();
            }
            return Container();
          },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState> (
        builder: (context, state) {

//          return (state is PageLoading) ? Container() :
        return BottomNavigationBar(
            currentIndex: BlocProvider.of<BottomNavBloc>(context).currentIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home,),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                title: Text('Favourites')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                title: Text('Shopping')
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile')
              )
//              BottomNavigationBarItem(),
            ],
            onTap: (index) => BlocProvider.of<BottomNavBloc>(context).add(PageTapped(index: index)),
          );
        },
      ),
    );
  }
}



//
//Scaffold(
//appBar: AppBar(title: const Text('Hello'),),
//body: Center(
//child: BlocBuilder<DailyRecipesBloc, DailyRecipesState>(
//builder: (context, state) {
//
//print(state);
//if (state is RecipesInitial){
//BlocProvider.of<DailyRecipesBloc>(context)
//    .add(dRecipesEvent.dRecipesRequested);
//}
//if (state is RecipesLoadSuccess){
//print(state.recipes[0].img);
//return Text('sucess');
//}
//if (state is RecipesLoadFailure) {
//return Text('failure');
//}
//if (state is RecipesLoadInProgress){
//return Center(child: CircularProgressIndicator());
//}
//return Text('nONE');
//},
//)
//),
//),