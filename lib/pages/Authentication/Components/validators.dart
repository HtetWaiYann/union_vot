class Validator {

  static String? validateUsername(String username){

    if(username.isEmpty){
      return "Required Field";
    }

    return null;

  }

  static String? validatePassword(String password){

    if(password.isEmpty){
      return "Required Field";
    }

    if(password.length != 4){
      return "Password should be 4 digits only.";
    }

    return null;

  }
  
}