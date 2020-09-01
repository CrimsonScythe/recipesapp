import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:tuple/tuple.dart';
class SpoonApiService {

  static final SpoonApiService _spoonApiService = SpoonApiService._internal();

  factory SpoonApiService(){
    return _spoonApiService;
  }

  SpoonApiService._internal();

  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY ="33eee3e309b548d7ad11d4042c834b21";

  Future<String> getIngredientImg(query) async {

    File filesaved;
    bool bol=false;

    Map<String, String> parameters = {
      'query': query,
      'number': '1',
      'apiKey': API_KEY,
    };

    Uri uri = Uri.https(
      _baseURL,
      '/food/ingredients/autocomplete',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {

      var response = await http.get(uri, headers: headers);
      final data = json.decode(response.body);
      print(data.runtimeType);
      print(data);
      final extension = data[0].values.toList()[1];
      print(extension);
      var imgresponse = await get('http://spoonacular.com/cdn/ingredients_100x100/$extension');


      final docDirect = await getApplicationDocumentsDirectory();
      File file = new File(join(docDirect.path, '$extension'));
      filesaved = await file.writeAsBytes(imgresponse.bodyBytes);
      bol=true;
      print(filesaved.path);

    } catch(err) {

    }
/// null img
    ///
    if (bol==true){

      return filesaved.path;



    }
    else{

      var nullimgres = await get('https://spoonacular.com/cdn/ingredients_100x100/a.jpg');

      final docDirect = await getApplicationDocumentsDirectory();
      File file = new File(join(docDirect.path, 'a.jpg'));
      filesaved = await file.writeAsBytes(nullimgres.bodyBytes);

      return filesaved.path;
    }

  }

}