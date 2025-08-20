import 'package:get/get.dart';

String? emailValidator(String? email){
    if (email == null || email.isEmpty){
      return 'Digite seu Email!';
    }
    if (!email.isEmail) return 'Digite um email válido';

    return null;
}

String? passwordValidator(String? password){
  if (password == null || password.isEmpty){
    return 'Digite sua Senha!';
  }
  if(password.length < 7){
    return 'A Senha tem q ser maior de 8 digitos!';
  }
  return null;
}

String? nameValidator(String? name){
  if (name == null || name.isEmpty){
    return 'Digite um nome!';
  }

  if(name.split(' ').length <= 1){
    return 'Digite seu nome completo!';
  }

  return null;
}

String? phoneValidator(String? phone){
    if (phone == null || phone.isEmpty){
    return 'Digite seu celular!';
  }

  if(!phone.isPhoneNumber){
    return 'Digite um número válido!';
  }

  return null;
}

String? cpfValidator(String? cpf){
    if (cpf == null || cpf.isEmpty){
    return 'Digite seu cpf!';
  }

  if(!cpf.isCpf){
    return 'Digite um CPF válido!';
  }

  return null;
}