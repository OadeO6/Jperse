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
  String tempVar = "";
  bool escapeChr = false;
  loop1:
  for (var rune in data.runes) {
    final chr = String.fromCharCode(rune);
    if (flag == null) {
      switch (chr) {
        case "{":
          tokens.add(Token(TokenType.openBrace, "{"));
        case "}":
          tokens.add(Token(TokenType.closeBrace, "}"));
        case "[":
          tokens.add(Token(TokenType.openBracket, "["));
        case "]":
          tokens.add(Token(TokenType.closeBracket, "]"));
        case ":":
          tokens.add(Token(TokenType.colon, ":"));
        case ",":
          tokens.add(Token(TokenType.comma, ","));
        case '"':
          flag = '"';
        case "'":
          flag = '"';
        case 'n':
          flag = 'n';
          tempVar = 'n';
        case 'f':
          flag = 'f';
          tempVar = 'f';
        case 't':
          flag = 't';
          tempVar = 't';

        case ' ' || "\n":
          continue;
        default:
          throw Exception("Unexpected '$chr'");
      }
      continue loop1;
    }
    tempVar += chr;
    switch (flag) {
      case 't':
        // Handle true
        if (!("true".startsWith(tempVar))) {
          // throw Exception("Unexpected i '${tempVar[tempVar.length - 1]}'");
          throw Exception("Unexpected  '${tempVar[0]}'");
        }
        if (tempVar == "true") {
            flag = null;
            tokens.add(Token(TokenType.boolean, tempVar));
            tempVar = "";
        }
      case 'f':
        // Handle false
        if (!("false".startsWith(tempVar))) {
          throw Exception("Unexpected '$chr'");
        }
        if (tempVar == "false") {
            flag = null;
            tokens.add(Token(TokenType.boolean, tempVar));
            tempVar = "";
        }
      case 'n':
        // Handle null
        if (!("null".startsWith(tempVar))) {
          throw Exception("Unexpected '$chr'");
        }
        if (tempVar == "null") {
            flag = null;
            tokens.add(Token(TokenType.nullType, tempVar));
            tempVar = "";
        }
      default:
        // Handle string
        if (flag == chr) {
          if (!escapeChr) {
            flag = null;
            tokens.add(Token(TokenType.string, tempVar));
            tempVar = "";
          }
        }
        if (chr == "\\") {
          escapeChr = !escapeChr;
        } else {
          escapeChr = false;
        }
    }
  }
  // if (escapeChr) {
  //   throw Exception("Unclosed '$escapeChr'");
  // }
  switch (tokens.length) {
    case 2:
      if (!((tokens[0].type == TokenType.openBrace && tokens[1].type == TokenType.closeBrace) || (tokens[0].type == TokenType.openBracket && tokens[1].type == TokenType.closeBracket))) {
        throw Exception("Unexpected ${tokens[0].value} ${tokens[1].value}");
      }
    case 1:
      if (!(tokens[0].type.category == TokenCategory.single)) {
        throw Exception("Unexpected ${tokens[0].value}");
      }
    case 0:
      throw Exception("Unexpected EOF");
  }
  return tokens;
}
