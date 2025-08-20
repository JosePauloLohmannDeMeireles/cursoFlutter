import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/respository/auth_errors.dart' as auth_errors;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  Future<AuthResult> validadeToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validadeToken, 
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> singIn({required String email, required String password}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin, 
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

   return handleUserOrError(result);
  }

  Future<AuthResult> singUp(UserModel user)async{
    final result = await _httpManager.restRequest(
      url: Endpoints.signup, 
      method: HttpMethods.post,
      body: user.toJson(),

    );
    return handleUserOrError(result);
  }


  handleUserOrError(Map<dynamic, dynamic> result){
    if(result['result'] != null){
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    }else{
      return AuthResult.error( auth_errors.authErrorsString(result['error']));
    }
  }
}