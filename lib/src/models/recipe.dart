import 'dart:convert';

class Recipe{

  final String _title;
  final String _url;
  final List<dynamic> _ingredients;
  final String _serve;
  String _img;
  final List<dynamic> _instructions;
  final List<dynamic> _nutrition;
  final String _timeis;
  final String _typeis;
  String _id;

  Recipe(this._title, this._url, this._ingredients, this._serve, this._img,
      this._instructions, this._nutrition, this._timeis, this._typeis, this._id);

  String get id => _id;
  String get img => _img;
  String get title => _title;
  String get serve => _serve;
  List<dynamic> get ingredients => _ingredients;
  String get time => _timeis;


  List<dynamic> get instructions => _instructions;

  set img(String value) {
    _img = value;
  }

  set id(String value) {
    _id = value;
  }

  Recipe.fromJson(Map<String, dynamic> json)
    : _title = json['title'],
     _url = json['url'],
  _ingredients = json['ingredients'],
  _serve = json['serve'],
  _timeis = json['timeis'],
  _typeis = json['typeis'],
  _nutrition = json['nutrition'],
  _id = json['id'],
  _instructions = json['instructions'],
  _img = json['img'];

  Map<String, dynamic> toJson() =>
      {
        'title' : _title,
        'url' : _url,
        'ingredients' : _ingredients,
        'serve' : _serve,
        'timeis' : _timeis,
        'typeis' : _typeis,
        'nutrition' : _nutrition,
        'id' : _id,
        'instructions' : _instructions,
        'img' : _img
      };

}