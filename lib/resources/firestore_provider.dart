import 'dart:io';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipes/src/models/favourite.dart';
import 'package:recipes/src/models/recipe.dart';
import 'package:recipes/src/models/rootlist.dart';
import 'package:recipes/src/models/shoppinglist.dart';
import 'package:recipes/src/models/user.dart';
import 'package:tuple/tuple.dart';
import '../src/constants.dart' as Constants;
import 'package:intl/intl.dart';


class FirestoreProvider{
  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String today = formatter.format(DateTime.now());

  Future<QuerySnapshot> getDailyRecipes() {
    return _firestore.collection('recipes').document(Constants.MEAT_DOC).collection(today).getDocuments();
  }


  Future<List<Favourite>> getFavouritesFirebase(userID) async {

    List<Favourite> lstFav = new List<Favourite>();
    QuerySnapshot querySnapshot = await _firestore.collection('users').document(userID).collection('favourites').getDocuments();
    querySnapshot.documents.forEach((fav) {
      lstFav.add(Favourite(fav.data['reciperef'], fav.data['ctime'], fav.data['key']));
    });


    lstFav.sort((a,b){
      return DateTime.parse(a.ctime).compareTo(DateTime.parse(b.ctime));
    });

    return lstFav;

  }

  Future<void> setFavouritesToFirebase(List<Favourite> favList, userID) async {

    final fireLst = List<Favourite>();

    final docs = await _firestore.collection('users').document(userID).collection('favourites').getDocuments();

    docs.documents.forEach((element) {
      fireLst.add(Favourite.fromJson(element.data));
    });


    /// delete favs not there
    docs.documents.forEach((element) async {
      /// remove
      if (!favList.contains(Favourite.fromJson(element.data))) {
        await _firestore.collection('users').document(userID).collection('favourites').document(element.documentID).delete();
      }

    });



    /// remove from favlist
    favList.removeWhere((element) => fireLst.contains(element));

    /// rest are new
    favList.forEach((element) async {
      await _firestore.collection('users').document(userID).collection('favourites').add(
          element.toJson()
      );
    });

  }


  Future<List<Recipe>> getRecipesList(List<ShoppingList> shplists) async {

//    shplists.removeWhere((element) => element.recipeID=='');

    List<Recipe> recipesList = new List(shplists.length);


    for (int i =0; i<shplists.length; i++) {
//      if (shplists[i].recipeID==''){continue;}
      DocumentSnapshot docSnap = await _firestore.document(shplists[i].recipeID).get();
      var imgUrl = docSnap.data['img'];
      if (!imgUrl.contains(new RegExp(r'(http)|(https)', caseSensitive: false))){
        imgUrl='http://'+imgUrl;
      }
      print(docSnap.data['id']);
      recipesList[i]=(Recipe.fromJson(docSnap.data));


//      var response = await get(imgUrl);
//
//      final docDirect = await getApplicationDocumentsDirectory();
//      File file = new File(join(docDirect.path, '$i.jpg'));
//      final filesaved = await file.writeAsBytes(response.bodyBytes);
//
      /// solve cdn issue
      recipesList[i].img=imgUrl;

      recipesList[i].id = shplists[i].recipeID;
    }

    return recipesList;


  }

  Future<FirebaseUser> getUser() =>
      _firebaseAuth.currentUser();

  Future<void> addUser(User user) {

    return _firestore.collection("users").document(user.uID)
        .setData(user.toJson());
  }

  Future<void> logOut() {
    _firebaseAuth.signOut();
  }

  Future<void> addtoShoppingList(uID, listID, recipeID, list) async {
/// each document in list corresponds to a unique recipe

    final docSnap = await _firestore.collection("users").document(uID).collection("shopping")
        .document(listID).collection("lists")
    .document(recipeID.toString().split('/').last).get();

    List<dynamic> inglst;

    if (docSnap.data != null){
      inglst = docSnap.data['inglist'];




    list.forEach((element) {
      if (!inglst.contains(element)){
        inglst.add(element);
      }
    });

    } else {
      inglst = list;
    }

    return _firestore.collection("users").document(uID).collection("shopping").document(listID).collection("lists").document(recipeID.toString().split('/').last)
        .setData(ShoppingList(recipeID, DateTime.now().toString(), inglst).toJson(), merge: true);

  }

  Future<String> createShoppingList(uID, name) async {

    final docRef = _firestore.collection("users").document(uID)
        .collection("shopping").document();
    final id = docRef.documentID;
    await _firestore.collection("users").document(uID)
        .collection("shopping")
        .document(id)
        .setData({'ctime':Timestamp.now(), 'name':name});
//    final listRef = _firestore.collection("users").document(uID).collection("shopping").document(id).collection("lists").document();
    return id;
//    _firestore.collection("users").document(uID).collection("shopping")
//    .document().setData(ShoppingList(recipeID, Timestamp.now(), list).toJson());

  }

//  Future<List<RootList>> getShoppingLists(uID) async {
//
//    List<RootList> rootLists = new List<RootList>();
//
//    final shoppingLists = await _firestore.collection("users").document(uID).collection("shopping").orderBy('ctime', descending: true)
//        .getDocuments();
//
//
//    for (int i=0; i < shoppingLists.documents.length; i++){
//
//      final docID = shoppingLists.documents[i].documentID;
//      final ctime = shoppingLists.documents[i].data['ctime'];
//      final name = shoppingLists.documents[i].data['name'];
//      final lst = await _firestore.collection("users").document(uID).collection("shopping").document(docID).collection("lists").getDocuments();
//      List<ShoppingList> shplist = lst.documents.map((e) => ShoppingList.fromJson(e.data)).toList();
//      rootLists.add(new RootList(docID, ctime, name, shplist));
//    }
//
//    return rootLists;
//
//  }


  /// add recipereference and ctime to db
//  Future<void> setFavourite(uID, recipeID) async {
//
//    /// autogenerated document since there is no ned to explicitly query
//    _firestore.collection("users").document(uID).collection("favourites")
//        .document().setData(Favourite(recipeID, Timestamp.now()).toJson());
//
//  }

//  void deleteIngredient() async {
//
//    _firestore.collection("users").document(uID).collection("shopping").document(listID)
//        .collection("lists").document().delete();
//
//
//  }

  Future<void> deleteFavourite(uID, recipeID) async {
    /// query document using the recipeid.
    /// then delete the document
    print('recipeID');
    print(recipeID);
    final querySnap = await _firestore.collection("users").document(uID).collection("favourites")
        .where('reciperef', isEqualTo: recipeID).getDocuments();
    final docID = querySnap.documents[0].documentID;
    await _firestore.collection("users").document(uID).collection("favourites").document(docID).delete();

  }

  /// retrieve recipes ref from db and query db to get resulting recipes
  /// returns list<Recipe>
  Future<List<Recipe>> getFavourites(uID) async {

    List<Recipe> recipesList = List<Recipe>();
    /// recipeID contains doc refrerence to recipe
    /// order by ctime
    final querySnaps = await _firestore.collection("users").document(uID).collection("favourites").orderBy('ctime', descending: true)
        .getDocuments();

//    final path = querySnaps.documents[0].data['reciperef'].toString().split('/');
    for (int i=0; i < querySnaps.documents.length; i++) {
      final path = querySnaps.documents[i].data['reciperef'];
      final docSnap = await _firestore.document(path).get();
      recipesList.add(Recipe.fromJson(docSnap.data));
    }

    return recipesList;
//    await _firestore.collection(path[0]).document(path[1]).collection(path[2]).document(path[3])
//    .ge;


  }


  Future<User> logInAnon() async {

    AuthResult authResult = await _firebaseAuth.signInAnonymously();
    FirebaseUser user = authResult.user;
    /// if user is deleted from console
    if (user.getIdToken() == null) {
      await _firebaseAuth.signOut();
      authResult = await _firebaseAuth.signInAnonymously();
      user = authResult.user;
    }
    assert (user != null);
    assert (user.getIdToken() != null);
    return User(user.uid, '', Timestamp.now(), '');

  }

  Future<User> logInWithGoogle() async {

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );

    final FirebaseUser user = (await _firebaseAuth.signInWithCredential(credential)).user;

    assert(user != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    //TODO: Please recheck assertions

    /**
     * Assertions work, so fill DB with userID
     */



    return User(user.uid, user.displayName, Timestamp.now(), user.photoUrl);


  }

  Future<User> logInWithFacebook() async {

    FacebookLogin facebookLogin = FacebookLogin();
    FacebookLoginResult facebookLoginResult = await facebookLogin.logIn(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.cancelledByUser:
        print('cancelled');
        break;
      case FacebookLoginStatus.error:
        print('error');
        break;
      case FacebookLoginStatus.loggedIn:
        print('loggedin');
        break;
    }

    final token = facebookLoginResult.accessToken.token;

    assert (facebookLoginResult.status == FacebookLoginStatus.loggedIn);


      final facebookAuthCred = FacebookAuthProvider.getCredential(accessToken: token);

      final FirebaseUser user =
          (await _firebaseAuth.signInWithCredential(facebookAuthCred)).user;

      assert(user.email != null);
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _firebaseAuth.currentUser();
      assert(user.uid == currentUser.uid);

      //TODO: Please recheck assertions

      /**
       * Assertions work, so fill DB with userID
       */

    return User(user.uid, user.displayName, Timestamp.now(), user.photoUrl);


  }


}