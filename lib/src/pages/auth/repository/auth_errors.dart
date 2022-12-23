String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';

    case 'Invalid session token':
      return 'Token inválido';

    case 'INVALID_FULLNAME':
      return 'Ocorreru um erro ao cadastrar usuário: Nome inválido';

    case 'INVALID_PHONE':
      return 'Ocorreru um erro ao cadastrar usuário: Celular inválido';

    case 'INVALID_CPF':
      return 'Ocorreru um erro ao cadastrar usuário: CPF inválido';

    default:
      return 'Um erro indefinido ocorreu';
  }
}
