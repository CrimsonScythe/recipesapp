import 'package:bloc/bloc.dart';
import 'package:recipes/resources/repository.dart';
import 'package:recipes/src/blocs/favourites/favourites_event.dart';
import 'package:recipes/src/blocs/favourites/favourites_state.dart';


class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {

  final _repository = Repository();

  FavouritesBloc() : super(FavouritesInitial());
//
  bool existFavourite(recipeID) {

    if (_repository.favouritesList==null) {
      return false;
    }
    if (_repository.favouritesList.isEmpty) {
      return false;
    }
    if (_repository.favouritesList.contains(recipeID)){
      return true;
    } else {
      return false;
    }

  }



  @override
  Stream<FavouritesState> mapEventToState(FavouritesEvent event) async* {


    if (event is AddFavourite) {
      final favs = await _repository.addFavouriteLocal(event.recipeID);
      _repository.favouritesList=favs;
//      await _repository.setFavourite(event.recipeID);
      yield FavouriteAdded();
    }

    if (event is RemoveFavourite) {
      final favs = await _repository.removeFavouriteLocal(event.recipeID);
      _repository.favouritesList=favs;
//      await _repository.deleteFavourites(event.recipeID);
      yield FavouriteRemoved();
    }


    if (event is GetFavourites) {

      final lst = await _repository.getFavouritesLocal();
      if (lst.length==0){
        yield NoFavourites();
      } else {
        yield FavouritesRetrieved(lst);
      }

    }

    if (event is FavouriteSharedAdded){
      yield FavouriteAdded();
    }

    if (event is FavouriteSharedNotAdded) {
      yield FavouriteRemoved();
    }

    if (event is RefreshFavourites) {
      yield FavouritesInitial();
    }

//    if (event is FavouriteSharedAdded) {
//      yield FavouriteAdded();
//    }
//
//    if (event is FavouriteSharedNotAdded) {
//      yield FavouriteRemoved();
//    }
//
//    if (event is AddFavourite) {
//      /// here we get recipeID from event
//      await _repository.addFavourite(_repository.user.uID, event.recipeID);
//      await _repository.setFavourite(event.recipeID);
//      yield FavouriteAdded();
//    }
//    if (event is RemoveFavourite) {
//      await _repository.removeFavourite(_repository.user.uID, event.recipeID);
//      await _repository.deleteFavourite(event.recipeID);
//      yield FavouriteRemoved();
//    }
//
//    if (event is GetFavourites) {
//      /// uid is gotten from repo
//      final recipeList = await _repository.getFavourites(_repository.user.uID);
//      yield FavouritesRetrieved(recipeList);
//    }

  }

}
