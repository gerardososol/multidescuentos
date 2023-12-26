import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

@immutable
class ServicesGetData{
  String? identifier;
  String? data;

  ServicesGetData();

  Future<Response?> getData({
    required String identifier,
    required String data
  }) async{
    if (identifier == "TypeAheadFieldTitlePrincipalScreen"){
      return http.get(Uri.parse(
          'http://multidescuentos.com.mx/api_multidescuento/index.php/getData/getSuggest?search=$data')
      );
    }
    return null;
  }
}