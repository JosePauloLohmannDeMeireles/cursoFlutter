import 'package:dio/dio.dart';
class HttpManager {

  Future<Map> restRequest({
    required String url,
    required String method,
    Map? headers,
    Map? body,
  }) async {

    final defaultHeader = headers?.cast<String, String>() ?? {}
    ..addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
      'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
      'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
    });
    
    Dio dio = Dio();

    try{
      Response response = await dio.request(
        url,
        options: Options(
          method: method,
          headers: defaultHeader
        ),
        data: body,
      );
      
      return response.data;

    }on DioError catch(e){
      return e.response?.data ?? {};
    } catch(e) {
      return {};
    }

  }
}

abstract class HttpMethods{
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}