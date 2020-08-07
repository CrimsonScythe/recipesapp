import 'package:cloud_firestore/cloud_firestore.dart';
import '../src/constants.dart' as Constants;
import 'package:intl/intl.dart';


class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String today = formatter.format(DateTime.now());

  Future<QuerySnapshot> getDailyRecipes() {
    return _firestore.collection('recipes').document(Constants.MEAT_DOC).collection(today).getDocuments();
  }


}