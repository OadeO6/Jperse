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
  var bracketCount = 0;
  var braceCount = 0;


  ASTNode buildASTNode(ASTNode node) {
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
            // decrease brace count
            braceCount--;
            //pop stack
            break braceLoop;
        } else {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }

        // check for colon
        pointer++;
        if (tokens[pointer].type != TokenType.colon) {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }

        // check for value
        // NOTE: redundancy
        pointer++;
        if (tokens[pointer].type.category == TokenCategory.single) {
          tempNode = ASTNode.value(tokens[pointer]);
        } else if (tokens[pointer].type == TokenType.openBrace) {
          // increase brace count
          braceCount++;
          // add to stack
          tempNode = ASTNode(ASTNodeType.object, []);
          buildASTNode(tempNode);
        } else if (tokens[pointer].type == TokenType.openBracket) {
          // increase bracket count
          bracketCount++;
          // add to stack
          tempNode = ASTNode(ASTNodeType.array, []);
          buildASTNode(tempNode);
        } else if (tokens[pointer].type == TokenType.closeBrace) {
          // decrease brace count
          braceCount--;
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
            // pop from stack
            braceCount--;
            // pop stack
            break braceLoop;
          case TokenType.comma:
            continue braceLoop;
          default:
            throw Exception("Missing ','");
        }
      }
      if ((pointer != size - 1) && (bracketCount == 0) && (braceCount == 0)) {
        throw Exception("Unexpected charater '${tokens[pointer+1].value}'");
      }
    }
    if (node.type == ASTNodeType.array) {
      bracketLoop:
      while (pointer < size) {
        pointer++;
        ASTNode nNode;
        if (tokens[pointer].type.category == TokenCategory.single) {
          nNode = ASTNode.value(tokens[pointer]);
        } else if (tokens[pointer].type == TokenType.openBrace) {
          // increase brace count
          braceCount++;
          // add to stack
          nNode = ASTNode(ASTNodeType.object, []);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.openBracket) {
          // increase brace count
          bracketCount++;
          // add to stack
          nNode = ASTNode(ASTNodeType.array, []);
          buildASTNode(nNode);
        } else if (tokens[pointer].type == TokenType.closeBracket) {
          // pop from stack
          bracketCount--;
          break bracketLoop;
        } else {
          throw Exception("Unexpected item ${tokens[pointer].value}");
        }
        node.children.add(nNode);

        // check end or comma
        pointer++;
        switch (tokens[pointer].type) {
          case TokenType.closeBracket:
            // pop from stack
            bracketCount--;
            break bracketLoop;
          case TokenType.comma:
            continue bracketLoop;
          default:
            throw Exception("Missing ','");
        }

        // break if end
      }
      if ((pointer != size - 1) && (bracketCount == 0) && (braceCount == 0)) {
        throw Exception("Unexpected charater '${tokens[pointer+1].value}'");
      }
    }
    return node;
  }


  if (tokens[0].type == TokenType.openBrace) {
    node = ASTNode(ASTNodeType.object, []);
    braceCount++;

  } else if (tokens[0].type == TokenType.openBracket) {
    node = ASTNode(ASTNodeType.array, []);
    bracketCount++;
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
