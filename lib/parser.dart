part of jsonp;

ASTNode parser(List<Token> tokens) {
  switch (tokens.length) {
    case 2:
      if (tokens[0].type == TokenType.openBrace &&
          tokens[1].type == TokenType.closeBrace) {
        return ASTNode(ASTNodeType.object);
      }
      if (tokens[0].type == TokenType.openBracket &&
          tokens[1].type == TokenType.closeBracket) {
        return ASTNode(ASTNodeType.array);
      }
    // case 1:
    //  if (tokens[0].type.category == TokenCategory.single) {
    //     throw Exception("Unexpected ${tokens[0].value}");
    //   }
    case 0:
      throw Exception("Unexpected EOF");
  }
  var size = tokens.length;
  var pointer = 0;
  final ASTNode node;


  ASTNode buildASTNode(ASTNode node) {
    print(node);
    print(99999);
    if (node.type == ASTNodeType.object) {
      braceLoop:
      while (pointer < size) {
        pointer++;
        ASTNode nNode = ASTNode(ASTNodeType.pair, []);
        ASTNode tempNode;


        // check for key
        if (tokens[pointer].type == TokenType.string) {
          nNode.children.add(ASTNode.key(tokens[pointer]));
        } else if (tokens[pointer].type == TokenType.closeBrace) {
            //pop stack
            break braceLoop;
        } else {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }

        print(tokens[pointer]);
        // check for colon
        pointer++;
        if (tokens[pointer].type != TokenType.colon) {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }
        print(tokens[pointer]);

        // check for value
        // NOTE: redundancy
        pointer++;
        if (tokens[pointer].type.category == TokenCategory.single) {
          tempNode = ASTNode.value(tokens[pointer]);
        } else if (tokens[pointer].type == TokenType.openBrace) {
          // add to stack
          tempNode = ASTNode(ASTNodeType.object, []);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.openBracket) {
          // add to stack
          tempNode = ASTNode(ASTNodeType.array);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.closeBrace) {
          // pop from stack
          break braceLoop;
        } else {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }
        nNode.children.add(tempNode);
        node.children.add(nNode);
        // check end or comma
        pointer++;
        switch (tokens[pointer].type) {
          case TokenType.closeBrace:
            // pop stack
            break braceLoop;
          case TokenType.comma:
            continue braceLoop;
          default:
            throw Exception("Missing ','");
        }
      }
      if (pointer != size - 1) {
        throw Exception("Unexpected charater '${tokens[pointer+1].value}'");
      }
    }
    if (node.type == ASTNodeType.array) {
      bracketLoop:
      while (pointer < size) {
      print(888888);
      print("$pointer $size");
        pointer++;
        ASTNode nNode;
          // print("loging1, $pointer");
          // print("loging1,   ${tokens[pointer]}");
        if (tokens[pointer].type.category == TokenCategory.single) {
          // print("loging2");
          nNode = ASTNode.value(tokens[pointer]);
        } else if (tokens[pointer].type == TokenType.openBrace) {
          // print("loging3");
          // add to stack
          nNode = ASTNode(ASTNodeType.object, []);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.openBracket) {
          // print("loging4");
          // add to stack
          nNode = ASTNode(ASTNodeType.array, []);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.closeBracket) {
          // pop from stack
          break bracketLoop;
        } else {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }
        node.children.add(nNode);
        // check end or comma
        pointer++;
        switch (tokens[pointer].type) {
          case TokenType.closeBracket:
            // pop stack
            break bracketLoop;
          case TokenType.comma:
            continue bracketLoop;
          default:
            throw Exception("Missing ','");
        }

        // break if end
      }
      if (pointer != size - 1) {
        throw Exception("Unexpected charater '${tokens[pointer+1].value}'");
      }
    }
    return node;
  }


  if (tokens[0].type == TokenType.openBrace) {
    node = ASTNode(ASTNodeType.object, []);
  } else if (tokens[0].type == TokenType.openBracket) {
    node = ASTNode(ASTNodeType.array, []);
  } else {
    throw Exception("Unexpected ${tokens[0].value}, $tokens[0]");
  }
  buildASTNode(node);
  return buildObject(node);
}

// Object buildObject(ASTNode node) {
ASTNode buildObject(ASTNode node) {
  return node;
}
