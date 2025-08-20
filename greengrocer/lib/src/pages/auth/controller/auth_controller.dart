import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/respository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();
  @override
  void onInit(){
    super.onInit();
    validadeToken();
  }

  Future<void> validadeToken() async {
    String? token = await utilsServices.getLocalDate(key: StorageKeys.token);

    if(token == null) return Get.offAllNamed(PagesRoutes.singInRoute);

    AuthResult result = await authRepository.validadeToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        singOut();
      } 
    );

  }

  void saveTokenAndProceedToBase(){
    utilsServices.saveLocalDate(key: StorageKeys.token, data: user.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> singIn({
    required String email, 
    required String password
  }) async {
    isLoading.value = true;
    AuthResult result = await authRepository.singIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        
        saveTokenAndProceedToBase();
      }, 
      error: (message) {
        utilsServices.showToast(
          message: message, 
          isError: true
        );
      }
    );
  }

  Future<void> singOut() async {
    user = UserModel();
    await utilsServices.removeLocalDate(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.singUp(user);
    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      }, 
      error: (message) {
        utilsServices.showToast(
          message: message, 
          isError: true
        );
      }
    );
  }
}