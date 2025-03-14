class Token {
  String refresh;
  String access;

  Token({required this.refresh, required this.access});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(refresh: json['refresh'], access: json['access']);
  }
}

class Data {
  String email;
  String full_name;
  Token tokens;

  Data({
    required this.email,
    required this.full_name,
    required this.tokens,
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        email: parsedJson['email'],
        full_name: parsedJson['full_name'],
        tokens: Token.fromJson(parsedJson['tokens']));
  }
}

class Credentials {
  Data data;

  Credentials({required this.data});

  factory Credentials.fromJson(Map<String, dynamic> parsedJson){
    return Credentials(
        data: Data.fromJson(parsedJson['data'])
    );
  }
}
