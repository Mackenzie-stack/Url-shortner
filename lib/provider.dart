import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_uri_caller.dart';

class UrlShortenerState extends ChangeNotifier {
  final urlController = TextEditingController();

  String shortUrlMessage = "Give some long url to convert";
bool _isLoading = false;

  void setisLoading() {
    _isLoading = true;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  String _resultConvertedUrl ='';
  handleGetLinkButton() async {
    final longUrl = urlController.text;
    final String shortUrl = await getShortLink(longUrl);
    _resultConvertedUrl = shortUrl;
   // shortUrlMessage = "$shortUrl";
    notifyListeners();

  }

  String? get resultConvertedUrl {
    //_resultConvertedUrl = getShortLink(longUrl)
    return _resultConvertedUrl;
  }

  void setClear(){
    _resultConvertedUrl ='';
    notifyListeners();
  }

  Future<String> getShortLink(String longUrl) async {
    final post_response = await http.post(Uri.parse("https://url-shortener-service.p.rapidapi.com/shorten"),
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        'X-RapidAPI-Host': 'url-shortener-service.p.rapidapi.com',
        'X-RapidAPI-Key': 'b6e294aee9msh0489bbb26a07f64p15ea0bjsn5ece7e47ffe6'
      },
    body: { 'url': longUrl}, );

    if(post_response.statusCode == 200){
      print("Succesfully Completed");
      final response = urlShortnerResponseFromJson(post_response.body);
      _resultConvertedUrl=response.resultUrl;
      _isLoading= false;
      notifyListeners();
      return response.resultUrl;
    }else{
      print("Error in Api");
      print(post_response.body);
      notifyListeners();
      return "There is some in shortening the url";
    }
  }
}