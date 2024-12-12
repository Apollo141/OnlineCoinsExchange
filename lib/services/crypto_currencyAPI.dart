import 'dart:convert';

import 'package:bitcoin_ticker/services/networking.dart';
import 'package:bitcoin_ticker/models/constans.dart';
class CryptoCurAPI{
final String curr;
final List<String> baseCurr;

CryptoCurAPI({required this.curr,required this.baseCurr});

Future<dynamic> getAllCurData() async{
print(baseCurr);


  final values = await Future.wait(baseCurr.map((item) async => await getCurDataByBase(item)).toList());
print(values[0]);
  return await values;

}

  Future<dynamic> getCurDataByBase(String baseCurrency) async{

String url = '$currencyApiUrl$curr/$baseCurrency$apiKey';
 ApiMapping apiMapping = await ApiMapping(url: url);
    var currData = await apiMapping.getApiRequestResponse();
   return await currData;



  }






}