import 'dart:convert';

import 'package:http/http.dart'as http;


class ApiMapping{
  final String url;
 ApiMapping({required this.url});

  Future getApiRequestResponse() async{
var responseData;
    http.Response response = await http.get(Uri.parse(url));
if(response.statusCode==200){

  responseData=await jsonDecode(response.body);

return await responseData;

}
else{
print(response.statusCode);
print(response.body);
}

  }





}