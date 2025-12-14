part of jsonp;
/***
{"ade": true, "bola": 555, "": "aaaa"}

{
  "name": "Alice",
  "age": null,
  "email": "alice@example.com",
  "phone": null,
  "isActive": true
}

Allowed Excape sequence
\" \\ \/ \b \f \n \r \t


Valid numbers
0
10
-5
3.14
1e9
-2.5E-10

***/
List<Token> lexer(String data) {
  final tokens = <Token>[];
  var flag = null;
  var numBrace = 0;
  var numBracket = 0;
  var tempVar = "";
  for (var rune in data.runes) {
    final chr = String.fromCharCode(rune);
    if (flag == null) {
      switch (chr) {
        case "{":
          // numBrace++;
          tokens.add(Token(TokenType.openBrace, "{"));
        case "}":
          // if (numBrace == 0) {
          //   throw Exception("Unexpected }");
          // }
          // numBrace--;
          tokens.add(Token(TokenType.closeBrace, "}"));
        case "[":
          // numBracket++;
          tokens.add(Token(TokenType.openBracket, "["));
        case "]":
          // if (numBracket == 0) {
          //   throw Exception("Unexpected ]");
          // }
          // numBracket--;
          tokens.add(Token(TokenType.closeBracket, "]"));
        case ":":
          tokens.add(Token(TokenType.colon, ":"));
        case ",":
          tokens.add(Token(TokenType.comma, ","));
        case '"':

        case "'":

        case 'n':

        case 't':

        // default:
        //   throw Exception("Unexpected $chr");
      }
    }
  }
  switch (tokens.length) {
    case 2:
      if (!((tokens[0].type == TokenType.openBrace && tokens[1].type == TokenType.closeBrace) || (tokens[0].type == TokenType.openBracket && tokens[1].type == TokenType.closeBracket))) {
        throw Exception("Unexpected ${tokens[0].value} ${tokens[1].value}");
      }
    case 1:
      if (!(SingleTokenType.values.contains(tokens[0].type))) {
        throw Exception("Unexpected ${tokens[0].value}");
      }
    case 0:
      throw Exception("Unexpected EOF");
  }
  return tokens;
}
