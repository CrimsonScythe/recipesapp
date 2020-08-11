import 'package:bloc/bloc.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_event.dart';
import 'package:recipes/src/blocs/bottomnav/bottomnav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(HomePageLoaded());
  int currentIndex = 0;
  @override
  Stream<BottomNavState> mapEventToState(BottomNavEvent event) async* {
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield PageLoading();

      if(this.currentIndex == 0){
        /// inject data into homepageloaded()
        yield HomePageLoaded();
      }

      if (this.currentIndex == 1){
        /// inject data into favouritespageloaded()
        yield FavouritesPageLoaded();
      }

      if (this.currentIndex == 2){
        /// inject data into favouritespageloaded()
        yield ProfilePageLoaded();
      }

    }

  }

}