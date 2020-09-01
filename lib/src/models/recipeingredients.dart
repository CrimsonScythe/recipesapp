import 'dart:convert';

class RecipeIngredients{

  final String _name;
  final String _img;

  RecipeIngredients(this._name, this._img);

  String get name => _name;
  String get img => _img;



//  RecipeIngredients.fromJson(Map<String, dynamic> json)
//      : _name = json['name'],
//        _id = json['id'];

//  Map<String, dynamic> toJson() =>
//      {
//        'title' : _title,
//        'url' : _url,
//        'ingredients' : _ingredients,
//        'serve' : _serve,
//        'timeis' : _timeis,
//        'typeis' : _typeis,
//        'nutrition' : _nutrition,
//        'id' : _id,
//        'instructions' : _instructions,
//        'img' : _img
//      };

}