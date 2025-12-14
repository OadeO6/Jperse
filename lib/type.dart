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
    return '''ASTNode{type: $type,
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

enum TokenType {
  number,
  string,
  boolean,
  nullType,
  openBrace,
  closeBrace,
  openBracket,
  closeBracket,
  colon,
  comma,
  eof,
}

enum SingleTokenType {
  number,
  string,
  boolean,
  nullType,
}

enum PairTokenType {
  leftBrace,
  rightBrace,
  leftBracket,
  rightBracket,
}
