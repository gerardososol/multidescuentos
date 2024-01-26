import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

@immutable
class ServicesGetData{
  ServicesGetData();

  Future<Response?> getData({required String identifier,String data = ""}) async{
    if (identifier == "TypeAheadFieldTitlePrincipalScreen"){
      return http.get(Uri.parse(
          'http://multidescuentos.com.mx/api_multidescuento/index.php/getData/getSuggest?search=$data')
      );
    }
    else if (identifier == "PanelPromosDataScreen"){
      return http.get(Uri.parse(
          'http://multidescuentos.com.mx/api_multidescuento/index.php/getData/getSuggest?search=$data')
      );
    }
    return null;
  }

  Future<Response> getAllData() async{
    return http.get(Uri.parse(
      'https://multidescuentos.com.mx/api_multidescuento/index.php/getData/getTodasAfi')
    );
  }

  Future<dynamic> getDataFromFile({required String identifier,String data = ""}) async{
    if (identifier == "GridViewPrincipalScreen") {
      String jsonString = await rootBundle.loadString('assets/json/principal_prueba.json');
      return await json.decode(jsonString);
    }
  }
}