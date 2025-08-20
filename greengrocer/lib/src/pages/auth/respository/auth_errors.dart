String authErrorsString(String? code){
  switch(code){
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';
    case 'Invalid session token':
      return 'Token invalido';
    case 'INVALID_FULLNAME':
      return 'Token invalido';
    case 'INVALID_PHONE':
      return 'Token invalido';
    case 'INVALID_CPF':
      return 'Token invalido';
    default:
      return 'Um erro Indefinido ocorreu';
  }
}