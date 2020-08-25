import 'dart:convert';

class Ingredients{

  final String _id;
  final String _name;

  Ingredients(this._id, this._name);

  String get id => _id;
  String get name => _name;

  Ingredients.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _id = json['id'];

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