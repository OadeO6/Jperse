part of jsonp;


class Token {
  TokenType type;
  String? value;
  Token(this.type, this.value);

  @override
  String toString() {
    return 'Token{type: $type, value: $value}';
  }
}

class ASTNode {
  final ASTNodeType type;
  final List<ASTNode> children;
  final Object? placeHolder;

  ASTNode(this.type, [this.children = const[], this.placeHolder = null]);

  ASTNode.key(Object? placeHolder_)
    : type = ASTNodeType.key, children = const[], placeHolder = placeHolder_;

  ASTNode.value(Object? placeHolder_)
    : type = ASTNodeType.value, children = const[], placeHolder = placeHolder_;

  @override
  String toString() {
    return '''ASTNode{type: $type, placeholder: $placeHolder
               children: [
                 ${children.map((e) => e.toString()).join("\n")}
               ]}''';
  }
}

enum ASTNodeType {
  object,
  array,
  pair,
  key,
  value,
}

enum TokenCategory {
  single,
  pair,
  other,
}

enum TokenType {
  number(TokenCategory.single),
  string(TokenCategory.single),
  boolean(TokenCategory.single),
  nullType(TokenCategory.single),
  openBrace(TokenCategory.pair),
  closeBrace(TokenCategory.pair),
  openBracket(TokenCategory.pair),
  closeBracket(TokenCategory.pair),
  colon(TokenCategory.other),
  comma(TokenCategory.other),
  eof(TokenCategory.other);

  final TokenCategory category;

  const TokenType(this.category);
}

// enum SingleTokenType {
//   number,
//   string,
//   boolean,
//   nullType,
// }
//
// enum PairTokenType {
//   leftBrace,
//   rightBrace,
//   leftBracket,
//   rightBracket,
// }
